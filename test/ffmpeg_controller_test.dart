import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_video_editor/src/business_logic/ffmpeg/ffmpeg_operation.dart';
import 'package:simple_video_editor/src/business_logic/ffmpeg/ffmpeg_controller.dart';
import 'package:simple_video_editor/src/business_logic/ffmpeg/service/core.dart';

// Mock FFmpeg service
class MockFFmpegService implements FfmpegService {
  @override
  Future<FFmpeg?> loadFFmpegScript() async {
    return null;
  }

  @override
  Future<String> getVideoThumbnail(String path, {FFmpeg? ffmpeg}) async {
    return 'mock_thumbnail_path';
  }

  @override
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
  }) async {
    return 'mock_edited_video_path';
  }
}

void main() {
  late FfmpegController controller;
  late MockFFmpegService mockService;

  setUp(() {
    mockService = MockFFmpegService();
    controller = FfmpegController.test(mockService);
  });

  group('FFmpeg Controller Tests', () {
    test('getVideoThumbnail returns expected path', () async {
      final thumbnailPath =
          await controller.getVideoThumbnail('test_video.mp4');
      expect(thumbnailPath, equals('mock_thumbnail_path'));
    });

    test('trimVideo returns expected path', () async {
      final editedPath = await controller.trimVideo(
        'test_video.mp4',
        '00:00:00',
        '00:00:10',
      );
      expect(editedPath, equals('mock_edited_video_path'));
    });

    test('compressVideo returns expected path', () async {
      final compressedPath = await controller.compressVideo('test_video.mp4');
      expect(compressedPath, equals('mock_edited_video_path'));
    });
  });
}
