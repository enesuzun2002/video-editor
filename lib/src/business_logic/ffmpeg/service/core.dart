import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../ffmpeg_operation.dart';

import 'ffmpeg_service.dart'
    if (dart.library.html) 'ffmpeg_service_web.dart'
    if (dart.library.io) 'ffmpeg_service_mobile.dart';

final ffmpegServiceProvider = Provider<FfmpegService>((ref) {
  return FfmpegService();
});

abstract class FfmpegService {
  factory FfmpegService() => getPlatformFfmpegService();

  // Make `loadFFmpegScript` optional by providing a default implementation.
  Future<FFmpeg?> loadFFmpegScript();

  // `getVideoThumbnail` is now an optional method.
  Future<String> getVideoThumbnail(XFile video, {FFmpeg? ffmpeg});

  // `editVideo` is also optional with a default unimplemented method.
  Future<String> editVideo(XFile video,
      {String? start,
      String? duration,
      FFmpeg? ffmpeg,
      FfmpegOperation operation = FfmpegOperation.trim});
}
