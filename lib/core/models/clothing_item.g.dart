// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clothing_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClothingItemImpl _$$ClothingItemImplFromJson(Map<String, dynamic> json) =>
    _$ClothingItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      imageUrl: json['imageUrl'] as String,
      additionalImages: (json['additionalImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      category: json['category'] as String,
      occasion: json['occasion'] as String,
      color: json['color'] as String,
      pattern: json['pattern'] as String,
      affiliateUrl: json['affiliateUrl'] as String,
      retailer: json['retailer'] as String,
      availableSizes: (json['availableSizes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      trendScore: (json['trendScore'] as num?)?.toDouble() ?? 0.0,
      trendTimestamp: DateTime.parse(json['trendTimestamp'] as String),
    );

Map<String, dynamic> _$$ClothingItemImplToJson(_$ClothingItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brand': instance.brand,
      'description': instance.description,
      'price': instance.price,
      'currency': instance.currency,
      'imageUrl': instance.imageUrl,
      'additionalImages': instance.additionalImages,
      'category': instance.category,
      'occasion': instance.occasion,
      'color': instance.color,
      'pattern': instance.pattern,
      'affiliateUrl': instance.affiliateUrl,
      'retailer': instance.retailer,
      'availableSizes': instance.availableSizes,
      'trendScore': instance.trendScore,
      'trendTimestamp': instance.trendTimestamp.toIso8601String(),
    };
