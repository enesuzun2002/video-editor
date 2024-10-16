// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ffmpeg_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FfmpegState {
  AsyncValue<FFmpeg?> get ffmpeg => throw _privateConstructorUsedError;
  XFile? get videoFile => throw _privateConstructorUsedError;

  /// Create a copy of FfmpegState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FfmpegStateCopyWith<FfmpegState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FfmpegStateCopyWith<$Res> {
  factory $FfmpegStateCopyWith(
          FfmpegState value, $Res Function(FfmpegState) then) =
      _$FfmpegStateCopyWithImpl<$Res, FfmpegState>;
  @useResult
  $Res call({AsyncValue<FFmpeg?> ffmpeg, XFile? videoFile});
}

/// @nodoc
class _$FfmpegStateCopyWithImpl<$Res, $Val extends FfmpegState>
    implements $FfmpegStateCopyWith<$Res> {
  _$FfmpegStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FfmpegState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ffmpeg = null,
    Object? videoFile = freezed,
  }) {
    return _then(_value.copyWith(
      ffmpeg: null == ffmpeg
          ? _value.ffmpeg
          : ffmpeg // ignore: cast_nullable_to_non_nullable
              as AsyncValue<FFmpeg?>,
      videoFile: freezed == videoFile
          ? _value.videoFile
          : videoFile // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FfmpegStateImplCopyWith<$Res>
    implements $FfmpegStateCopyWith<$Res> {
  factory _$$FfmpegStateImplCopyWith(
          _$FfmpegStateImpl value, $Res Function(_$FfmpegStateImpl) then) =
      __$$FfmpegStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<FFmpeg?> ffmpeg, XFile? videoFile});
}

/// @nodoc
class __$$FfmpegStateImplCopyWithImpl<$Res>
    extends _$FfmpegStateCopyWithImpl<$Res, _$FfmpegStateImpl>
    implements _$$FfmpegStateImplCopyWith<$Res> {
  __$$FfmpegStateImplCopyWithImpl(
      _$FfmpegStateImpl _value, $Res Function(_$FfmpegStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FfmpegState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ffmpeg = null,
    Object? videoFile = freezed,
  }) {
    return _then(_$FfmpegStateImpl(
      ffmpeg: null == ffmpeg
          ? _value.ffmpeg
          : ffmpeg // ignore: cast_nullable_to_non_nullable
              as AsyncValue<FFmpeg?>,
      videoFile: freezed == videoFile
          ? _value.videoFile
          : videoFile // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ));
  }
}

/// @nodoc

class _$FfmpegStateImpl implements _FfmpegState {
  const _$FfmpegStateImpl({this.ffmpeg = const AsyncLoading(), this.videoFile});

  @override
  @JsonKey()
  final AsyncValue<FFmpeg?> ffmpeg;
  @override
  final XFile? videoFile;

  @override
  String toString() {
    return 'FfmpegState(ffmpeg: $ffmpeg, videoFile: $videoFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FfmpegStateImpl &&
            (identical(other.ffmpeg, ffmpeg) || other.ffmpeg == ffmpeg) &&
            (identical(other.videoFile, videoFile) ||
                other.videoFile == videoFile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ffmpeg, videoFile);

  /// Create a copy of FfmpegState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FfmpegStateImplCopyWith<_$FfmpegStateImpl> get copyWith =>
      __$$FfmpegStateImplCopyWithImpl<_$FfmpegStateImpl>(this, _$identity);
}

abstract class _FfmpegState implements FfmpegState {
  const factory _FfmpegState(
      {final AsyncValue<FFmpeg?> ffmpeg,
      final XFile? videoFile}) = _$FfmpegStateImpl;

  @override
  AsyncValue<FFmpeg?> get ffmpeg;
  @override
  XFile? get videoFile;

  /// Create a copy of FfmpegState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FfmpegStateImplCopyWith<_$FfmpegStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
