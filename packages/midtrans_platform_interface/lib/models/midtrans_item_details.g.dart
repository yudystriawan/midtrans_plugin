// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'midtrans_item_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MidtransItemDetailsImpl _$$MidtransItemDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$MidtransItemDetailsImpl(
      id: json['id'] as String?,
      price: (json['price'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      name: json['name'] as String,
      brand: json['brand'] as String?,
      category: json['category'] as String?,
      merchantName: json['merchantName'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$MidtransItemDetailsImplToJson(
        _$MidtransItemDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'quantity': instance.quantity,
      'name': instance.name,
      'brand': instance.brand,
      'category': instance.category,
      'merchantName': instance.merchantName,
      'url': instance.url,
    };
