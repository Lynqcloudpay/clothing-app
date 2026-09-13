// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterOptionsImpl _$$FilterOptionsImplFromJson(Map<String, dynamic> json) =>
    _$FilterOptionsImpl(
      minBudget: (json['minBudget'] as num?)?.toDouble(),
      maxBudget: (json['maxBudget'] as num?)?.toDouble(),
      occasions: (json['occasions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferredBrands: (json['preferredBrands'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferredColors: (json['preferredColors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sortBy: json['sortBy'] as String? ?? 'trending',
    );

Map<String, dynamic> _$$FilterOptionsImplToJson(_$FilterOptionsImpl instance) =>
    <String, dynamic>{
      'minBudget': instance.minBudget,
      'maxBudget': instance.maxBudget,
      'occasions': instance.occasions,
      'categories': instance.categories,
      'preferredBrands': instance.preferredBrands,
      'preferredColors': instance.preferredColors,
      'sortBy': instance.sortBy,
    };
