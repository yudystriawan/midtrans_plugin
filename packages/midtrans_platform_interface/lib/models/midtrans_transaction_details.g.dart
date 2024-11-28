// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'midtrans_transaction_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MidtransTransactionDetailsImpl _$$MidtransTransactionDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$MidtransTransactionDetailsImpl(
      orderId: json['order_id'] as String,
      grossAmount: (json['gross_amount'] as num).toInt(),
    );

Map<String, dynamic> _$$MidtransTransactionDetailsImplToJson(
        _$MidtransTransactionDetailsImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'gross_amount': instance.grossAmount,
    };
