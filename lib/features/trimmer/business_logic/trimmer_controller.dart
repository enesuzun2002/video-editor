import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

import 'trimmer_service.dart';
import 'trimmer_state.dart';

part 'trimmer_controller.g.dart';

@riverpod
class TrimmerController extends _$TrimmerController {
  late final TrimmerService trimmerService;

  @override
  TrimmerState build(String path) {
    trimmerService = ref.watch(trimmerServiceProvider);

    createInputController(path);

    // While FFmpeg is loading, return the state as loading
    return const TrimmerState();
  }

  Future<void> createInputController(String path) async {
    VideoPlayerController controller =
        await trimmerService.createController(path);

    state = state.copyWith(inputController: AsyncData(controller));

    controller.play();

    setInitialRangeValues();
  }

  void setInitialRangeValues() {
    try {
      var controller = state.inputController.value;
      if (controller == null) throw ("Video player controller is null!");

      // Load the FFmpeg script
      RangeValues rangeValues =
          trimmerService.setInitialRangeValues(state.inputController.value!);

      // Once loaded, update the state with the loaded FFmpeg instance
      state = state.copyWith(rangeValues: AsyncData(rangeValues));
    } catch (e, st) {
      // If there's an error, update the state with an error
      state = state.copyWith(rangeValues: AsyncError(e, st));
      debugPrint("Error setting range values: $e");
    }
  }

  void updateRangeValues(RangeValues value) {
    state = state.copyWith(rangeValues: AsyncData(value));
  }

  Future<void> createOutputController(String path) async {
    state = state.copyWith(outputController: AsyncLoading());
    try {
      VideoPlayerController controller =
          await trimmerService.createController(path);

      state = state.copyWith(outputController: AsyncData(controller));

      controller.play();
    } catch (e, st) {
      // If there's an error, update the state with an error
      state = state.copyWith(outputController: AsyncError(e, st));
      debugPrint("Error creating output controller: $e");
    }
  }
}
