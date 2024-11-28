// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'midtrans_transaction_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MidtransTransactionDetails _$MidtransTransactionDetailsFromJson(
    Map<String, dynamic> json) {
  return _MidtransTransactionDetails.fromJson(json);
}

/// @nodoc
mixin _$MidtransTransactionDetails {
  String get orderId => throw _privateConstructorUsedError;
  int get grossAmount => throw _privateConstructorUsedError;

  /// Serializes this MidtransTransactionDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MidtransTransactionDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MidtransTransactionDetailsCopyWith<MidtransTransactionDetails>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MidtransTransactionDetailsCopyWith<$Res> {
  factory $MidtransTransactionDetailsCopyWith(MidtransTransactionDetails value,
          $Res Function(MidtransTransactionDetails) then) =
      _$MidtransTransactionDetailsCopyWithImpl<$Res,
          MidtransTransactionDetails>;
  @useResult
  $Res call({String orderId, int grossAmount});
}

/// @nodoc
class _$MidtransTransactionDetailsCopyWithImpl<$Res,
        $Val extends MidtransTransactionDetails>
    implements $MidtransTransactionDetailsCopyWith<$Res> {
  _$MidtransTransactionDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MidtransTransactionDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? grossAmount = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      grossAmount: null == grossAmount
          ? _value.grossAmount
          : grossAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MidtransTransactionDetailsImplCopyWith<$Res>
    implements $MidtransTransactionDetailsCopyWith<$Res> {
  factory _$$MidtransTransactionDetailsImplCopyWith(
          _$MidtransTransactionDetailsImpl value,
          $Res Function(_$MidtransTransactionDetailsImpl) then) =
      __$$MidtransTransactionDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String orderId, int grossAmount});
}

/// @nodoc
class __$$MidtransTransactionDetailsImplCopyWithImpl<$Res>
    extends _$MidtransTransactionDetailsCopyWithImpl<$Res,
        _$MidtransTransactionDetailsImpl>
    implements _$$MidtransTransactionDetailsImplCopyWith<$Res> {
  __$$MidtransTransactionDetailsImplCopyWithImpl(
      _$MidtransTransactionDetailsImpl _value,
      $Res Function(_$MidtransTransactionDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MidtransTransactionDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? grossAmount = null,
  }) {
    return _then(_$MidtransTransactionDetailsImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      grossAmount: null == grossAmount
          ? _value.grossAmount
          : grossAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MidtransTransactionDetailsImpl implements _MidtransTransactionDetails {
  const _$MidtransTransactionDetailsImpl(
      {required this.orderId, required this.grossAmount});

  factory _$MidtransTransactionDetailsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MidtransTransactionDetailsImplFromJson(json);

  @override
  final String orderId;
  @override
  final int grossAmount;

  @override
  String toString() {
    return 'MidtransTransactionDetails(orderId: $orderId, grossAmount: $grossAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MidtransTransactionDetailsImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.grossAmount, grossAmount) ||
                other.grossAmount == grossAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, orderId, grossAmount);

  /// Create a copy of MidtransTransactionDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MidtransTransactionDetailsImplCopyWith<_$MidtransTransactionDetailsImpl>
      get copyWith => __$$MidtransTransactionDetailsImplCopyWithImpl<
          _$MidtransTransactionDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MidtransTransactionDetailsImplToJson(
      this,
    );
  }
}

abstract class _MidtransTransactionDetails
    implements MidtransTransactionDetails {
  const factory _MidtransTransactionDetails(
      {required final String orderId,
      required final int grossAmount}) = _$MidtransTransactionDetailsImpl;

  factory _MidtransTransactionDetails.fromJson(Map<String, dynamic> json) =
      _$MidtransTransactionDetailsImpl.fromJson;

  @override
  String get orderId;
  @override
  int get grossAmount;

  /// Create a copy of MidtransTransactionDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MidtransTransactionDetailsImplCopyWith<_$MidtransTransactionDetailsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
