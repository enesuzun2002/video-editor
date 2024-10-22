import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

import 'compression_service.dart';
import 'compression_state.dart';

part 'compression_controller.g.dart';

@riverpod
class CompressionController extends _$CompressionController {
  late final CompressionService compressionService;

  @override
  CompressionState build(String path) {
    compressionService = ref.watch(compressionServiceProvider);

    createInputController(path);

    // While FFmpeg is loading, return the state as loading
    return const CompressionState();
  }

  Future<void> createInputController(String path) async {
    VideoPlayerController controller =
        await compressionService.createController(path);

    state = state.copyWith(inputController: AsyncData(controller));

    controller.play();
  }

  Future<void> createOutputController(String path) async {
    state = state.copyWith(outputController: AsyncLoading());
    try {
      VideoPlayerController controller =
          await compressionService.createController(path);

      state = state.copyWith(outputController: AsyncData(controller));

      controller.play();
    } catch (e, st) {
      // If there's an error, update the state with an error
      state = state.copyWith(outputController: AsyncError(e, st));
      debugPrint("Error creating output controller: $e");
    }
  }
}
