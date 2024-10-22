// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compression_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CompressionState {
  AsyncValue<VideoPlayerController?> get inputController =>
      throw _privateConstructorUsedError;
  AsyncValue<VideoPlayerController?>? get outputController =>
      throw _privateConstructorUsedError;

  /// Create a copy of CompressionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompressionStateCopyWith<CompressionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompressionStateCopyWith<$Res> {
  factory $CompressionStateCopyWith(
          CompressionState value, $Res Function(CompressionState) then) =
      _$CompressionStateCopyWithImpl<$Res, CompressionState>;
  @useResult
  $Res call(
      {AsyncValue<VideoPlayerController?> inputController,
      AsyncValue<VideoPlayerController?>? outputController});
}

/// @nodoc
class _$CompressionStateCopyWithImpl<$Res, $Val extends CompressionState>
    implements $CompressionStateCopyWith<$Res> {
  _$CompressionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompressionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputController = null,
    Object? outputController = freezed,
  }) {
    return _then(_value.copyWith(
      inputController: null == inputController
          ? _value.inputController
          : inputController // ignore: cast_nullable_to_non_nullable
              as AsyncValue<VideoPlayerController?>,
      outputController: freezed == outputController
          ? _value.outputController
          : outputController // ignore: cast_nullable_to_non_nullable
              as AsyncValue<VideoPlayerController?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompressionStateImplCopyWith<$Res>
    implements $CompressionStateCopyWith<$Res> {
  factory _$$CompressionStateImplCopyWith(_$CompressionStateImpl value,
          $Res Function(_$CompressionStateImpl) then) =
      __$$CompressionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<VideoPlayerController?> inputController,
      AsyncValue<VideoPlayerController?>? outputController});
}

/// @nodoc
class __$$CompressionStateImplCopyWithImpl<$Res>
    extends _$CompressionStateCopyWithImpl<$Res, _$CompressionStateImpl>
    implements _$$CompressionStateImplCopyWith<$Res> {
  __$$CompressionStateImplCopyWithImpl(_$CompressionStateImpl _value,
      $Res Function(_$CompressionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompressionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputController = null,
    Object? outputController = freezed,
  }) {
    return _then(_$CompressionStateImpl(
      inputController: null == inputController
          ? _value.inputController
          : inputController // ignore: cast_nullable_to_non_nullable
              as AsyncValue<VideoPlayerController?>,
      outputController: freezed == outputController
          ? _value.outputController
          : outputController // ignore: cast_nullable_to_non_nullable
              as AsyncValue<VideoPlayerController?>?,
    ));
  }
}

/// @nodoc

class _$CompressionStateImpl implements _CompressionState {
  const _$CompressionStateImpl(
      {this.inputController = const AsyncLoading(), this.outputController});

  @override
  @JsonKey()
  final AsyncValue<VideoPlayerController?> inputController;
  @override
  final AsyncValue<VideoPlayerController?>? outputController;

  @override
  String toString() {
    return 'CompressionState(inputController: $inputController, outputController: $outputController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompressionStateImpl &&
            (identical(other.inputController, inputController) ||
                other.inputController == inputController) &&
            (identical(other.outputController, outputController) ||
                other.outputController == outputController));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, inputController, outputController);

  /// Create a copy of CompressionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompressionStateImplCopyWith<_$CompressionStateImpl> get copyWith =>
      __$$CompressionStateImplCopyWithImpl<_$CompressionStateImpl>(
          this, _$identity);
}

abstract class _CompressionState implements CompressionState {
  const factory _CompressionState(
          {final AsyncValue<VideoPlayerController?> inputController,
          final AsyncValue<VideoPlayerController?>? outputController}) =
      _$CompressionStateImpl;

  @override
  AsyncValue<VideoPlayerController?> get inputController;
  @override
  AsyncValue<VideoPlayerController?>? get outputController;

  /// Create a copy of CompressionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompressionStateImplCopyWith<_$CompressionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
