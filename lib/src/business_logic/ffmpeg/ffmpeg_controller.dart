import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter/foundation.dart';
import 'ffmpeg_operation.dart';
import 'service/core.dart';

class FfmpegController {
  late final FfmpegService ffmpegService;
  FFmpeg? _ffmpegInstance;

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

  Future<String> getVideoThumbnail(String path) {
    return ffmpegService.getVideoThumbnail(path, ffmpeg: _ffmpegInstance);
  }

  Future<String> trimVideo(String path, String start, String duration) {
    return ffmpegService.editVideo(path,
        start: start, duration: duration, ffmpeg: _ffmpegInstance);
  }

  Future<String> compressVideo(
    String path, {
    // constant rate factor
    String compressionRate = "25",
    bool scale = true,
    String quality = "720",
  }) {
    return ffmpegService.editVideo(path,
        ffmpeg: _ffmpegInstance,
        operation: FfmpegOperation.compress,
        compressionRate: compressionRate,
        scale: scale,
        quality: quality);
  }
}
