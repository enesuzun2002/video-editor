import 'package:cross_file/cross_file.dart';
import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import '../ffmpeg_operation.dart';

import 'ffmpeg_service.dart'
    if (dart.library.html) 'ffmpeg_service_web.dart'
    if (dart.library.io) 'ffmpeg_service_mobile.dart';

abstract class FfmpegService {
  factory FfmpegService() => getPlatformFfmpegService();

  // Make `loadFFmpegScript` optional by providing a default implementation.
  Future<FFmpeg?> loadFFmpegScript();

  // `getVideoThumbnail` is now an optional method.
  Future<String> getVideoThumbnail(String path, {FFmpeg? ffmpeg});

  // `editVideo` is also optional with a default unimplemented method.
  Future<String> editVideo(
    String path, {
    String? start,
    String? duration,
    FFmpeg? ffmpeg,
    FfmpegOperation operation = FfmpegOperation.trim,
    // constant rate factor
    String compressionRate = "25",
    bool scale = true,
    String quality = "720",
  });
}
