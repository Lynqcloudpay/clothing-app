// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      preferences: json['preferences'] == null
          ? const UserPreferences()
          : UserPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'preferences': instance.preferences,
    };

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      preferredOccasions: (json['preferredOccasions'] as List<dynamic>?)
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
      budgetMin: (json['budgetMin'] as num?)?.toDouble(),
      budgetMax: (json['budgetMax'] as num?)?.toDouble(),
      units: json['units'] as String? ?? 'cm',
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'preferredOccasions': instance.preferredOccasions,
      'preferredBrands': instance.preferredBrands,
      'preferredColors': instance.preferredColors,
      'budgetMin': instance.budgetMin,
      'budgetMax': instance.budgetMax,
      'units': instance.units,
    };
