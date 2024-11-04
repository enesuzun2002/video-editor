import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'business_logic/ffmpeg/ffmpeg_controller.dart';

final videoEditorProvider = Provider.autoDispose((ref) {
  // Initialize ffmpeg here
  ref.watch(ffmpegControllerProvider);
  // Get the notifier for original ffmpeg controller
  final ffmpegControllerNotifier = ref.watch(ffmpegControllerProvider.notifier);
  return VideoEditor._(ffmpegControllerNotifier);
});

class VideoEditor {
  final FfmpegController ffmpegController;

  VideoEditor._(this.ffmpegController);

  /// Compress a video file
  Future<String> compressVideo(
    XFile videoFile,
  ) async {
    return await ffmpegController.compressVideo(videoFile);
  }

  /// Trim a video file
  Future<String?> trimVideo(
    XFile videoFile, {
    required String start,
    required String duration,
  }) async {
    return await ffmpegController.trimVideo(videoFile, start, duration);
  }

  /// Generate a thumbnail from a video
  Future<String?> generateThumbnail(
    XFile videoFile,
  ) async {
    return await ffmpegController.getVideoThumbnail(videoFile);
  }
}
