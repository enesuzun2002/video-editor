import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_editor/src/business_logic/ffmpeg/ffmpeg_operation.dart';
import 'package:video_editor/src/business_logic/ffmpeg/ffmpeg_state.dart';
import 'package:video_editor/src/business_logic/ffmpeg/ffmpeg_controller.dart';
import 'package:video_editor/src/business_logic/ffmpeg/service/core.dart';

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
  late ProviderContainer container;
  late MockFFmpegService mockService;

  setUp(() {
    mockService = MockFFmpegService();
    container = ProviderContainer(
      overrides: [
        ffmpegServiceProvider.overrideWithValue(mockService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('FFmpeg Controller Tests', () {
    test('initial state should be loading', () {
      final state = container.read(ffmpegControllerProvider);
      expect(state.ffmpeg, isA<AsyncLoading>());
    });

    test('getVideoThumbnail returns expected path', () async {
      final controller = container.read(ffmpegControllerProvider.notifier);
      final mockVideo = XFile('test_video.mp4');

      final thumbnailPath = await controller.getVideoThumbnail(mockVideo);
      expect(thumbnailPath, equals('mock_thumbnail_path'));
    });

    test('trimVideo returns expected path', () async {
      final controller = container.read(ffmpegControllerProvider.notifier);
      final mockVideo = XFile('test_video.mp4');

      final editedPath = await controller.trimVideo(
        mockVideo,
        '00:00:00',
        '00:00:10',
      );
      expect(editedPath, equals('mock_edited_video_path'));
    });

    test('compressVideo returns expected path', () async {
      final controller = container.read(ffmpegControllerProvider.notifier);
      final mockVideo = XFile('test_video.mp4');

      final compressedPath = await controller.compressVideo(mockVideo);
      expect(compressedPath, equals('mock_edited_video_path'));
    });
  });

  group('FFmpeg State Tests', () {
    test('copyWith creates new instance with updated values', () {
      final initialState = FfmpegState();
      final newState = initialState.copyWith(
        ffmpeg: const AsyncData(null),
      );

      expect(newState.ffmpeg, isA<AsyncData>());
      expect(identical(initialState, newState), isFalse);
    });

    test('states with same values should be equal', () {
      final state1 = FfmpegState();
      final state2 = FfmpegState();
      expect(state1, equals(state2));
    });
  });
}
