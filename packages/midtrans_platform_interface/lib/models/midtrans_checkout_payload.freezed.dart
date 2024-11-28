// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'midtrans_checkout_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MidtransCheckoutPayload _$MidtransCheckoutPayloadFromJson(
    Map<String, dynamic> json) {
  return _MidtransCheckoutPayload.fromJson(json);
}

/// @nodoc
mixin _$MidtransCheckoutPayload {
  MidtransTransactionDetails get transactionDetails =>
      throw _privateConstructorUsedError;
  List<MidtransItemDetails>? get itemDetails =>
      throw _privateConstructorUsedError;

  /// Serializes this MidtransCheckoutPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MidtransCheckoutPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MidtransCheckoutPayloadCopyWith<MidtransCheckoutPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MidtransCheckoutPayloadCopyWith<$Res> {
  factory $MidtransCheckoutPayloadCopyWith(MidtransCheckoutPayload value,
          $Res Function(MidtransCheckoutPayload) then) =
      _$MidtransCheckoutPayloadCopyWithImpl<$Res, MidtransCheckoutPayload>;
  @useResult
  $Res call(
      {MidtransTransactionDetails transactionDetails,
      List<MidtransItemDetails>? itemDetails});

  $MidtransTransactionDetailsCopyWith<$Res> get transactionDetails;
}

/// @nodoc
class _$MidtransCheckoutPayloadCopyWithImpl<$Res,
        $Val extends MidtransCheckoutPayload>
    implements $MidtransCheckoutPayloadCopyWith<$Res> {
  _$MidtransCheckoutPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MidtransCheckoutPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionDetails = null,
    Object? itemDetails = freezed,
  }) {
    return _then(_value.copyWith(
      transactionDetails: null == transactionDetails
          ? _value.transactionDetails
          : transactionDetails // ignore: cast_nullable_to_non_nullable
              as MidtransTransactionDetails,
      itemDetails: freezed == itemDetails
          ? _value.itemDetails
          : itemDetails // ignore: cast_nullable_to_non_nullable
              as List<MidtransItemDetails>?,
    ) as $Val);
  }

  /// Create a copy of MidtransCheckoutPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MidtransTransactionDetailsCopyWith<$Res> get transactionDetails {
    return $MidtransTransactionDetailsCopyWith<$Res>(_value.transactionDetails,
        (value) {
      return _then(_value.copyWith(transactionDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MidtransCheckoutPayloadImplCopyWith<$Res>
    implements $MidtransCheckoutPayloadCopyWith<$Res> {
  factory _$$MidtransCheckoutPayloadImplCopyWith(
          _$MidtransCheckoutPayloadImpl value,
          $Res Function(_$MidtransCheckoutPayloadImpl) then) =
      __$$MidtransCheckoutPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MidtransTransactionDetails transactionDetails,
      List<MidtransItemDetails>? itemDetails});

  @override
  $MidtransTransactionDetailsCopyWith<$Res> get transactionDetails;
}

/// @nodoc
class __$$MidtransCheckoutPayloadImplCopyWithImpl<$Res>
    extends _$MidtransCheckoutPayloadCopyWithImpl<$Res,
        _$MidtransCheckoutPayloadImpl>
    implements _$$MidtransCheckoutPayloadImplCopyWith<$Res> {
  __$$MidtransCheckoutPayloadImplCopyWithImpl(
      _$MidtransCheckoutPayloadImpl _value,
      $Res Function(_$MidtransCheckoutPayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of MidtransCheckoutPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionDetails = null,
    Object? itemDetails = freezed,
  }) {
    return _then(_$MidtransCheckoutPayloadImpl(
      transactionDetails: null == transactionDetails
          ? _value.transactionDetails
          : transactionDetails // ignore: cast_nullable_to_non_nullable
              as MidtransTransactionDetails,
      itemDetails: freezed == itemDetails
          ? _value._itemDetails
          : itemDetails // ignore: cast_nullable_to_non_nullable
              as List<MidtransItemDetails>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MidtransCheckoutPayloadImpl implements _MidtransCheckoutPayload {
  const _$MidtransCheckoutPayloadImpl(
      {required this.transactionDetails,
      final List<MidtransItemDetails>? itemDetails})
      : _itemDetails = itemDetails;

  factory _$MidtransCheckoutPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$MidtransCheckoutPayloadImplFromJson(json);

  @override
  final MidtransTransactionDetails transactionDetails;
  final List<MidtransItemDetails>? _itemDetails;
  @override
  List<MidtransItemDetails>? get itemDetails {
    final value = _itemDetails;
    if (value == null) return null;
    if (_itemDetails is EqualUnmodifiableListView) return _itemDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MidtransCheckoutPayload(transactionDetails: $transactionDetails, itemDetails: $itemDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MidtransCheckoutPayloadImpl &&
            (identical(other.transactionDetails, transactionDetails) ||
                other.transactionDetails == transactionDetails) &&
            const DeepCollectionEquality()
                .equals(other._itemDetails, _itemDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, transactionDetails,
      const DeepCollectionEquality().hash(_itemDetails));

  /// Create a copy of MidtransCheckoutPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MidtransCheckoutPayloadImplCopyWith<_$MidtransCheckoutPayloadImpl>
      get copyWith => __$$MidtransCheckoutPayloadImplCopyWithImpl<
          _$MidtransCheckoutPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MidtransCheckoutPayloadImplToJson(
      this,
    );
  }
}

abstract class _MidtransCheckoutPayload implements MidtransCheckoutPayload {
  const factory _MidtransCheckoutPayload(
          {required final MidtransTransactionDetails transactionDetails,
          final List<MidtransItemDetails>? itemDetails}) =
      _$MidtransCheckoutPayloadImpl;

  factory _MidtransCheckoutPayload.fromJson(Map<String, dynamic> json) =
      _$MidtransCheckoutPayloadImpl.fromJson;

  @override
  MidtransTransactionDetails get transactionDetails;
  @override
  List<MidtransItemDetails>? get itemDetails;

  /// Create a copy of MidtransCheckoutPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MidtransCheckoutPayloadImplCopyWith<_$MidtransCheckoutPayloadImpl>
      get copyWith => throw _privateConstructorUsedError;
}
