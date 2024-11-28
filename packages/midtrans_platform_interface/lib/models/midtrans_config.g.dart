// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'midtrans_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MidtransConfigImpl _$$MidtransConfigImplFromJson(Map<String, dynamic> json) =>
    _$MidtransConfigImpl(
      clientKey: json['clientKey'] as String,
      baseUrl: json['baseUrl'] as String,
      enableLog: json['enableLog'] as bool? ?? false,
      isProduction: json['isProduction'] as bool? ?? false,
    );

Map<String, dynamic> _$$MidtransConfigImplToJson(
        _$MidtransConfigImpl instance) =>
    <String, dynamic>{
      'clientKey': instance.clientKey,
      'baseUrl': instance.baseUrl,
      'enableLog': instance.enableLog,
      'isProduction': instance.isProduction,
    };
