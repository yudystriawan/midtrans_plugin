// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'midtrans_transaction_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MidtransTransactionResult _$MidtransTransactionResultFromJson(
    Map<String, dynamic> json) {
  return _MidtransTransactionResult.fromJson(json);
}

/// @nodoc
mixin _$MidtransTransactionResult {
  String? get transactionId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get paymentType => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this MidtransTransactionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MidtransTransactionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MidtransTransactionResultCopyWith<MidtransTransactionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MidtransTransactionResultCopyWith<$Res> {
  factory $MidtransTransactionResultCopyWith(MidtransTransactionResult value,
          $Res Function(MidtransTransactionResult) then) =
      _$MidtransTransactionResultCopyWithImpl<$Res, MidtransTransactionResult>;
  @useResult
  $Res call(
      {String? transactionId,
      String status,
      String paymentType,
      String? message});
}

/// @nodoc
class _$MidtransTransactionResultCopyWithImpl<$Res,
        $Val extends MidtransTransactionResult>
    implements $MidtransTransactionResultCopyWith<$Res> {
  _$MidtransTransactionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MidtransTransactionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = freezed,
    Object? status = null,
    Object? paymentType = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MidtransTransactionResultImplCopyWith<$Res>
    implements $MidtransTransactionResultCopyWith<$Res> {
  factory _$$MidtransTransactionResultImplCopyWith(
          _$MidtransTransactionResultImpl value,
          $Res Function(_$MidtransTransactionResultImpl) then) =
      __$$MidtransTransactionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? transactionId,
      String status,
      String paymentType,
      String? message});
}

/// @nodoc
class __$$MidtransTransactionResultImplCopyWithImpl<$Res>
    extends _$MidtransTransactionResultCopyWithImpl<$Res,
        _$MidtransTransactionResultImpl>
    implements _$$MidtransTransactionResultImplCopyWith<$Res> {
  __$$MidtransTransactionResultImplCopyWithImpl(
      _$MidtransTransactionResultImpl _value,
      $Res Function(_$MidtransTransactionResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of MidtransTransactionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = freezed,
    Object? status = null,
    Object? paymentType = null,
    Object? message = freezed,
  }) {
    return _then(_$MidtransTransactionResultImpl(
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MidtransTransactionResultImpl implements _MidtransTransactionResult {
  const _$MidtransTransactionResultImpl(
      {this.transactionId,
      required this.status,
      required this.paymentType,
      this.message});

  factory _$MidtransTransactionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$MidtransTransactionResultImplFromJson(json);

  @override
  final String? transactionId;
  @override
  final String status;
  @override
  final String paymentType;
  @override
  final String? message;

  @override
  String toString() {
    return 'MidtransTransactionResult(transactionId: $transactionId, status: $status, paymentType: $paymentType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MidtransTransactionResultImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, transactionId, status, paymentType, message);

  /// Create a copy of MidtransTransactionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MidtransTransactionResultImplCopyWith<_$MidtransTransactionResultImpl>
      get copyWith => __$$MidtransTransactionResultImplCopyWithImpl<
          _$MidtransTransactionResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MidtransTransactionResultImplToJson(
      this,
    );
  }
}

abstract class _MidtransTransactionResult implements MidtransTransactionResult {
  const factory _MidtransTransactionResult(
      {final String? transactionId,
      required final String status,
      required final String paymentType,
      final String? message}) = _$MidtransTransactionResultImpl;

  factory _MidtransTransactionResult.fromJson(Map<String, dynamic> json) =
      _$MidtransTransactionResultImpl.fromJson;

  @override
  String? get transactionId;
  @override
  String get status;
  @override
  String get paymentType;
  @override
  String? get message;

  /// Create a copy of MidtransTransactionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MidtransTransactionResultImplCopyWith<_$MidtransTransactionResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
