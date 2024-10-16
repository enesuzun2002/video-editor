import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'ffmpeg_state.freezed.dart';

@freezed
class FfmpegState with _$FfmpegState {
  const factory FfmpegState(
      {@Default(AsyncLoading()) AsyncValue<FFmpeg?> ffmpeg,
      XFile? videoFile}) = _FfmpegState;
}
