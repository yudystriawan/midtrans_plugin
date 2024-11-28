// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'midtrans_transaction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MidtransTransactionResultImpl _$$MidtransTransactionResultImplFromJson(
        Map<String, dynamic> json) =>
    _$MidtransTransactionResultImpl(
      transactionId: json['transactionId'] as String?,
      status: json['status'] as String?,
      paymentType: json['paymentType'] as String?,
      message: json['message'] as String?,
      isCancelled: json['isCancelled'] as bool? ?? false,
      isFailed: json['isFailed'] as bool? ?? false,
    );

Map<String, dynamic> _$$MidtransTransactionResultImplToJson(
        _$MidtransTransactionResultImpl instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'status': instance.status,
      'paymentType': instance.paymentType,
      'message': instance.message,
      'isCancelled': instance.isCancelled,
      'isFailed': instance.isFailed,
    };
