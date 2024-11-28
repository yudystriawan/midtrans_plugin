// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'midtrans_checkout_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MidtransCheckoutPayloadImpl _$$MidtransCheckoutPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$MidtransCheckoutPayloadImpl(
      transactionDetails: MidtransTransactionDetails.fromJson(
          json['transactionDetails'] as Map<String, dynamic>),
      itemDetails: (json['itemDetails'] as List<dynamic>?)
          ?.map((e) => MidtransItemDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MidtransCheckoutPayloadImplToJson(
        _$MidtransCheckoutPayloadImpl instance) =>
    <String, dynamic>{
      'transactionDetails': instance.transactionDetails.toJson(),
      'itemDetails': instance.itemDetails?.map((e) => e.toJson()).toList(),
    };
