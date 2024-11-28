// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'midtrans_transaction_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MidtransTransactionDetailsImpl _$$MidtransTransactionDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$MidtransTransactionDetailsImpl(
      orderId: json['orderId'] as String,
      grossAmount: (json['grossAmount'] as num).toInt(),
    );

Map<String, dynamic> _$$MidtransTransactionDetailsImplToJson(
        _$MidtransTransactionDetailsImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'grossAmount': instance.grossAmount,
    };
