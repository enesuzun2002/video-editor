import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player/video_player.dart';

part 'trimmer_state.freezed.dart';

@freezed
class TrimmerState with _$TrimmerState {
  const factory TrimmerState({
    @Default(AsyncLoading()) AsyncValue<VideoPlayerController?> inputController,
    AsyncValue<VideoPlayerController?>? outputController,
    @Default(AsyncLoading()) AsyncValue<RangeValues?> rangeValues,
  }) = _TrimmerState;
}
