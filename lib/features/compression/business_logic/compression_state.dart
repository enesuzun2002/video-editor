import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player/video_player.dart';

part 'compression_state.freezed.dart';

@freezed
class CompressionState with _$CompressionState {
  const factory CompressionState({
    @Default(AsyncLoading()) AsyncValue<VideoPlayerController?> inputController,
    AsyncValue<VideoPlayerController?>? outputController,
  }) = _CompressionState;
}
