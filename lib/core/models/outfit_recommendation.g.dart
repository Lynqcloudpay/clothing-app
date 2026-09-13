// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outfit_recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutfitRecommendationImpl _$$OutfitRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$OutfitRecommendationImpl(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ClothingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      fitScore: (json['fitScore'] as num).toDouble(),
      styleScore: (json['styleScore'] as num).toDouble(),
      recommendationReason: json['recommendationReason'] as String,
      bodyTypeAdvice: json['bodyTypeAdvice'] as String,
      recommendedSize: json['recommendedSize'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$OutfitRecommendationImplToJson(
        _$OutfitRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'items': instance.items,
      'fitScore': instance.fitScore,
      'styleScore': instance.styleScore,
      'recommendationReason': instance.recommendationReason,
      'bodyTypeAdvice': instance.bodyTypeAdvice,
      'recommendedSize': instance.recommendedSize,
      'totalPrice': instance.totalPrice,
    };
