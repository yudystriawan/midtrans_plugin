// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'midtrans_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MidtransConfigImpl _$$MidtransConfigImplFromJson(Map<String, dynamic> json) =>
    _$MidtransConfigImpl(
      clientKey: json['client_key'] as String,
      baseUrl: json['base_url'] as String,
      enableLog: json['enable_log'] as bool? ?? false,
      isProduction: json['is_production'] as bool? ?? false,
    );

Map<String, dynamic> _$$MidtransConfigImplToJson(
        _$MidtransConfigImpl instance) =>
    <String, dynamic>{
      'client_key': instance.clientKey,
      'base_url': instance.baseUrl,
      'enable_log': instance.enableLog,
      'is_production': instance.isProduction,
    };
