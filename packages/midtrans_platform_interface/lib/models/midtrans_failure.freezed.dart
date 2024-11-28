// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'midtrans_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MidtransFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? code, String? message) unexpectedError,
    required TResult Function() initializeFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? code, String? message)? unexpectedError,
    TResult? Function()? initializeFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? code, String? message)? unexpectedError,
    TResult Function()? initializeFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedError value) unexpectedError,
    required TResult Function(_InitializeFailed value) initializeFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedError value)? unexpectedError,
    TResult? Function(_InitializeFailed value)? initializeFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedError value)? unexpectedError,
    TResult Function(_InitializeFailed value)? initializeFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MidtransFailureCopyWith<$Res> {
  factory $MidtransFailureCopyWith(
          MidtransFailure value, $Res Function(MidtransFailure) then) =
      _$MidtransFailureCopyWithImpl<$Res, MidtransFailure>;
}

/// @nodoc
class _$MidtransFailureCopyWithImpl<$Res, $Val extends MidtransFailure>
    implements $MidtransFailureCopyWith<$Res> {
  _$MidtransFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MidtransFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UnexpectedErrorImplCopyWith<$Res> {
  factory _$$UnexpectedErrorImplCopyWith(_$UnexpectedErrorImpl value,
          $Res Function(_$UnexpectedErrorImpl) then) =
      __$$UnexpectedErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? code, String? message});
}

/// @nodoc
class __$$UnexpectedErrorImplCopyWithImpl<$Res>
    extends _$MidtransFailureCopyWithImpl<$Res, _$UnexpectedErrorImpl>
    implements _$$UnexpectedErrorImplCopyWith<$Res> {
  __$$UnexpectedErrorImplCopyWithImpl(
      _$UnexpectedErrorImpl _value, $Res Function(_$UnexpectedErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MidtransFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_$UnexpectedErrorImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnexpectedErrorImpl implements _UnexpectedError {
  const _$UnexpectedErrorImpl({this.code, this.message});

  @override
  final String? code;
  @override
  final String? message;

  @override
  String toString() {
    return 'MidtransFailure.unexpectedError(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnexpectedErrorImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  /// Create a copy of MidtransFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnexpectedErrorImplCopyWith<_$UnexpectedErrorImpl> get copyWith =>
      __$$UnexpectedErrorImplCopyWithImpl<_$UnexpectedErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? code, String? message) unexpectedError,
    required TResult Function() initializeFailed,
  }) {
    return unexpectedError(code, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? code, String? message)? unexpectedError,
    TResult? Function()? initializeFailed,
  }) {
    return unexpectedError?.call(code, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? code, String? message)? unexpectedError,
    TResult Function()? initializeFailed,
    required TResult orElse(),
  }) {
    if (unexpectedError != null) {
      return unexpectedError(code, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedError value) unexpectedError,
    required TResult Function(_InitializeFailed value) initializeFailed,
  }) {
    return unexpectedError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedError value)? unexpectedError,
    TResult? Function(_InitializeFailed value)? initializeFailed,
  }) {
    return unexpectedError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedError value)? unexpectedError,
    TResult Function(_InitializeFailed value)? initializeFailed,
    required TResult orElse(),
  }) {
    if (unexpectedError != null) {
      return unexpectedError(this);
    }
    return orElse();
  }
}

abstract class _UnexpectedError implements MidtransFailure {
  const factory _UnexpectedError({final String? code, final String? message}) =
      _$UnexpectedErrorImpl;

  String? get code;
  String? get message;

  /// Create a copy of MidtransFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnexpectedErrorImplCopyWith<_$UnexpectedErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitializeFailedImplCopyWith<$Res> {
  factory _$$InitializeFailedImplCopyWith(_$InitializeFailedImpl value,
          $Res Function(_$InitializeFailedImpl) then) =
      __$$InitializeFailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitializeFailedImplCopyWithImpl<$Res>
    extends _$MidtransFailureCopyWithImpl<$Res, _$InitializeFailedImpl>
    implements _$$InitializeFailedImplCopyWith<$Res> {
  __$$InitializeFailedImplCopyWithImpl(_$InitializeFailedImpl _value,
      $Res Function(_$InitializeFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MidtransFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitializeFailedImpl implements _InitializeFailed {
  const _$InitializeFailedImpl();

  @override
  String toString() {
    return 'MidtransFailure.initializeFailed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitializeFailedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? code, String? message) unexpectedError,
    required TResult Function() initializeFailed,
  }) {
    return initializeFailed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? code, String? message)? unexpectedError,
    TResult? Function()? initializeFailed,
  }) {
    return initializeFailed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? code, String? message)? unexpectedError,
    TResult Function()? initializeFailed,
    required TResult orElse(),
  }) {
    if (initializeFailed != null) {
      return initializeFailed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnexpectedError value) unexpectedError,
    required TResult Function(_InitializeFailed value) initializeFailed,
  }) {
    return initializeFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnexpectedError value)? unexpectedError,
    TResult? Function(_InitializeFailed value)? initializeFailed,
  }) {
    return initializeFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnexpectedError value)? unexpectedError,
    TResult Function(_InitializeFailed value)? initializeFailed,
    required TResult orElse(),
  }) {
    if (initializeFailed != null) {
      return initializeFailed(this);
    }
    return orElse();
  }
}

abstract class _InitializeFailed implements MidtransFailure {
  const factory _InitializeFailed() = _$InitializeFailedImpl;
}
