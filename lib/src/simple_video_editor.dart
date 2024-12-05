import 'business_logic/ffmpeg/ffmpeg_controller.dart';

class SimpleVideoEditor {
  late final FfmpegController ffmpegController;

  SimpleVideoEditor() {
    ffmpegController = FfmpegController();
  }

  /// Compress a video file
  Future<String> compressVideo(
    String path, {
    // constant rate factor
    String compressionRate = "25",
    bool scale = true,
    String quality = "720",
  }) async {
    return await ffmpegController.compressVideo(path,
        compressionRate: compressionRate, scale: scale, quality: quality);
  }

  /// Trim a video file
  Future<String?> trimVideo(
    String path, {
    required String start,
    required String duration,
  }) async {
    return await ffmpegController.trimVideo(path, start, duration);
  }

  /// Generate a thumbnail from a video
  Future<String?> generateThumbnail(
    String path,
  ) async {
    return await ffmpegController.getVideoThumbnail(path);
  }
}
