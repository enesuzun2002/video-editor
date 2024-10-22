import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_editor/business_logic/ffmpeg/ffmpeg_operation.dart';
import 'package:video_editor/business_logic/ffmpeg/ffmpeg_state.dart';
import 'ffmpeg_service.dart';

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

  void setPickedVideo(XFile videoFile) async {
    state = state.copyWith(videoFile: videoFile);
  }

  Future<Uint8List> getVideoThumbnail() {
    return ffmpegService.getVideoThumbnail(state.videoFile!,
        ffmpeg: state.ffmpeg.value);
  }

  Future<String> trimVideo(String start, String duration) {
    return ffmpegService.editVideo(state.videoFile!, start: start, duration: duration,
        ffmpeg: state.ffmpeg.value);
  }

  Future<String> compressVideo() {
    return ffmpegService.editVideo(state.videoFile!,
        ffmpeg: state.ffmpeg.value, operation: FfmpegOperation.compress);
  }
}
