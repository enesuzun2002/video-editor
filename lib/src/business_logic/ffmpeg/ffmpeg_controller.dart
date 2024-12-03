import 'package:cross_file/cross_file.dart';
import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter/foundation.dart';
import 'ffmpeg_operation.dart';
import 'service/core.dart';

class FfmpegController {
  late final FfmpegService ffmpegService;
  late FFmpeg? _ffmpegInstance;

  FfmpegController() {
    ffmpegService = FfmpegService();

    // Start loading FFmpeg asynchronously
    _loadFFmpegScript();
  }

  FfmpegController.test(FfmpegService service) {
    ffmpegService = service;

    // Start loading FFmpeg asynchronously
    _loadFFmpegScript();
  }

  // Function to load FFmpeg asynchronously and update the state
  Future<void> _loadFFmpegScript() async {
    try {
      // Load the FFmpeg script
      _ffmpegInstance = await ffmpegService.loadFFmpegScript();
    } catch (e) {
      debugPrint("Error loading FFmpeg: $e");
    }
  }

  Future<String> getVideoThumbnail(XFile videoFile) {
    return ffmpegService.getVideoThumbnail(videoFile, ffmpeg: _ffmpegInstance);
  }

  Future<String> trimVideo(XFile videoFile, String start, String duration) {
    return ffmpegService.editVideo(videoFile,
        start: start, duration: duration, ffmpeg: _ffmpegInstance);
  }

  Future<String> compressVideo(
    XFile videoFile, {
    // constant rate factor
    String compressionRate = "25",
    bool scale = true,
    String quality = "720",
  }) {
    return ffmpegService.editVideo(videoFile,
        ffmpeg: _ffmpegInstance, operation: FfmpegOperation.compress);
  }
}
