// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trimmer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TrimmerState {
  AsyncValue<VideoPlayerController?> get inputController =>
      throw _privateConstructorUsedError;
  AsyncValue<VideoPlayerController?>? get outputController =>
      throw _privateConstructorUsedError;
  AsyncValue<RangeValues?> get rangeValues =>
      throw _privateConstructorUsedError;

  /// Create a copy of TrimmerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrimmerStateCopyWith<TrimmerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrimmerStateCopyWith<$Res> {
  factory $TrimmerStateCopyWith(
          TrimmerState value, $Res Function(TrimmerState) then) =
      _$TrimmerStateCopyWithImpl<$Res, TrimmerState>;
  @useResult
  $Res call(
      {AsyncValue<VideoPlayerController?> inputController,
      AsyncValue<VideoPlayerController?>? outputController,
      AsyncValue<RangeValues?> rangeValues});
}

/// @nodoc
class _$TrimmerStateCopyWithImpl<$Res, $Val extends TrimmerState>
    implements $TrimmerStateCopyWith<$Res> {
  _$TrimmerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrimmerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputController = null,
    Object? outputController = freezed,
    Object? rangeValues = null,
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
      rangeValues: null == rangeValues
          ? _value.rangeValues
          : rangeValues // ignore: cast_nullable_to_non_nullable
              as AsyncValue<RangeValues?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrimmerStateImplCopyWith<$Res>
    implements $TrimmerStateCopyWith<$Res> {
  factory _$$TrimmerStateImplCopyWith(
          _$TrimmerStateImpl value, $Res Function(_$TrimmerStateImpl) then) =
      __$$TrimmerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<VideoPlayerController?> inputController,
      AsyncValue<VideoPlayerController?>? outputController,
      AsyncValue<RangeValues?> rangeValues});
}

/// @nodoc
class __$$TrimmerStateImplCopyWithImpl<$Res>
    extends _$TrimmerStateCopyWithImpl<$Res, _$TrimmerStateImpl>
    implements _$$TrimmerStateImplCopyWith<$Res> {
  __$$TrimmerStateImplCopyWithImpl(
      _$TrimmerStateImpl _value, $Res Function(_$TrimmerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrimmerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputController = null,
    Object? outputController = freezed,
    Object? rangeValues = null,
  }) {
    return _then(_$TrimmerStateImpl(
      inputController: null == inputController
          ? _value.inputController
          : inputController // ignore: cast_nullable_to_non_nullable
              as AsyncValue<VideoPlayerController?>,
      outputController: freezed == outputController
          ? _value.outputController
          : outputController // ignore: cast_nullable_to_non_nullable
              as AsyncValue<VideoPlayerController?>?,
      rangeValues: null == rangeValues
          ? _value.rangeValues
          : rangeValues // ignore: cast_nullable_to_non_nullable
              as AsyncValue<RangeValues?>,
    ));
  }
}

/// @nodoc

class _$TrimmerStateImpl implements _TrimmerState {
  const _$TrimmerStateImpl(
      {this.inputController = const AsyncLoading(),
      this.outputController,
      this.rangeValues = const AsyncLoading()});

  @override
  @JsonKey()
  final AsyncValue<VideoPlayerController?> inputController;
  @override
  final AsyncValue<VideoPlayerController?>? outputController;
  @override
  @JsonKey()
  final AsyncValue<RangeValues?> rangeValues;

  @override
  String toString() {
    return 'TrimmerState(inputController: $inputController, outputController: $outputController, rangeValues: $rangeValues)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrimmerStateImpl &&
            (identical(other.inputController, inputController) ||
                other.inputController == inputController) &&
            (identical(other.outputController, outputController) ||
                other.outputController == outputController) &&
            (identical(other.rangeValues, rangeValues) ||
                other.rangeValues == rangeValues));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, inputController, outputController, rangeValues);

  /// Create a copy of TrimmerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrimmerStateImplCopyWith<_$TrimmerStateImpl> get copyWith =>
      __$$TrimmerStateImplCopyWithImpl<_$TrimmerStateImpl>(this, _$identity);
}

abstract class _TrimmerState implements TrimmerState {
  const factory _TrimmerState(
      {final AsyncValue<VideoPlayerController?> inputController,
      final AsyncValue<VideoPlayerController?>? outputController,
      final AsyncValue<RangeValues?> rangeValues}) = _$TrimmerStateImpl;

  @override
  AsyncValue<VideoPlayerController?> get inputController;
  @override
  AsyncValue<VideoPlayerController?>? get outputController;
  @override
  AsyncValue<RangeValues?> get rangeValues;

  /// Create a copy of TrimmerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrimmerStateImplCopyWith<_$TrimmerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
