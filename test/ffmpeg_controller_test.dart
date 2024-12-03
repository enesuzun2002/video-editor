import 'package:cross_file/cross_file.dart';
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
  Future<String> getVideoThumbnail(XFile videoFile, {FFmpeg? ffmpeg}) async {
    return 'mock_thumbnail_path';
  }

  @override
  Future<String> editVideo(
    XFile videoFile, {
    String? start,
    String? duration,
    FFmpeg? ffmpeg,
    FfmpegOperation operation = FfmpegOperation.trim,
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
      final mockVideo = XFile('test_video.mp4');
      final thumbnailPath = await controller.getVideoThumbnail(mockVideo);
      expect(thumbnailPath, equals('mock_thumbnail_path'));
    });

    test('trimVideo returns expected path', () async {
      final mockVideo = XFile('test_video.mp4');
      final editedPath = await controller.trimVideo(
        mockVideo,
        '00:00:00',
        '00:00:10',
      );
      expect(editedPath, equals('mock_edited_video_path'));
    });

    test('compressVideo returns expected path', () async {
      final mockVideo = XFile('test_video.mp4');
      final compressedPath = await controller.compressVideo(mockVideo);
      expect(compressedPath, equals('mock_edited_video_path'));
    });
  });
}
