// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SizeChartImpl _$$SizeChartImplFromJson(Map<String, dynamic> json) =>
    _$SizeChartImpl(
      brand: json['brand'] as String,
      category: json['category'] as String,
      gender: json['gender'] as String,
      sizes: (json['sizes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SizeRange.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$SizeChartImplToJson(_$SizeChartImpl instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'category': instance.category,
      'gender': instance.gender,
      'sizes': instance.sizes,
    };

_$SizeRangeImpl _$$SizeRangeImplFromJson(Map<String, dynamic> json) =>
    _$SizeRangeImpl(
      chestMin: (json['chestMin'] as num).toDouble(),
      chestMax: (json['chestMax'] as num).toDouble(),
      waistMin: (json['waistMin'] as num).toDouble(),
      waistMax: (json['waistMax'] as num).toDouble(),
      hipMin: (json['hipMin'] as num).toDouble(),
      hipMax: (json['hipMax'] as num).toDouble(),
    );

Map<String, dynamic> _$$SizeRangeImplToJson(_$SizeRangeImpl instance) =>
    <String, dynamic>{
      'chestMin': instance.chestMin,
      'chestMax': instance.chestMax,
      'waistMin': instance.waistMin,
      'waistMax': instance.waistMax,
      'hipMin': instance.hipMin,
      'hipMax': instance.hipMax,
    };
