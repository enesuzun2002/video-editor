import 'package:cross_file/cross_file.dart';

import 'business_logic/ffmpeg/ffmpeg_controller.dart';

class VideoEditor {
  late final FfmpegController ffmpegController;

  VideoEditor() {
    ffmpegController = FfmpegController();
  }

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
