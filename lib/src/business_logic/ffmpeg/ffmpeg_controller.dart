import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'ffmpeg_operation.dart';
import 'ffmpeg_state.dart';
import 'service/core.dart';

final ffmpegControllerProvider =
    NotifierProvider<FfmpegController, FfmpegState>(() {
  return FfmpegController();
});

class FfmpegController extends Notifier<FfmpegState> {
  late final FfmpegService ffmpegService;

  @override
  FfmpegState build() {
    ffmpegService = ref.watch(ffmpegServiceProvider);

    // Start loading FFmpeg asynchronously
    _loadFFmpegScript();

    // While FFmpeg is loading, return the state as loading
    return const FfmpegState(
      ffmpeg: AsyncLoading(),
    );
  }

  // Function to load FFmpeg asynchronously and update the state
  Future<void> _loadFFmpegScript() async {
    try {
      // Load the FFmpeg script
      final ffmpegInstance = await ffmpegService.loadFFmpegScript();

      // Once loaded, update the state with the loaded FFmpeg instance
      state = state.copyWith(ffmpeg: AsyncData(ffmpegInstance));
    } catch (e, st) {
      // If there's an error, update the state with an error
      state = state.copyWith(ffmpeg: AsyncError(e, st));
      debugPrint("Error loading FFmpeg: $e");
    }
  }

  Future<String> getVideoThumbnail(XFile videoFile) {
    return ffmpegService.getVideoThumbnail(videoFile,
        ffmpeg: state.ffmpeg.value);
  }

  Future<String> trimVideo(XFile videoFile, String start, String duration) {
    return ffmpegService.editVideo(videoFile,
        start: start, duration: duration, ffmpeg: state.ffmpeg.value);
  }

  Future<String> compressVideo(XFile videoFile) {
    return ffmpegService.editVideo(videoFile,
        ffmpeg: state.ffmpeg.value, operation: FfmpegOperation.compress);
  }
}
