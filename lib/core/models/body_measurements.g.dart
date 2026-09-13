// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_measurements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BodyMeasurementsImpl _$$BodyMeasurementsImplFromJson(
        Map<String, dynamic> json) =>
    _$BodyMeasurementsImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      chestCircumference: (json['chestCircumference'] as num).toDouble(),
      waistCircumference: (json['waistCircumference'] as num).toDouble(),
      hipCircumference: (json['hipCircumference'] as num).toDouble(),
      inseam: (json['inseam'] as num).toDouble(),
      shoulderWidth: (json['shoulderWidth'] as num).toDouble(),
      armLength: (json['armLength'] as num).toDouble(),
      neckCircumference: (json['neckCircumference'] as num).toDouble(),
      torsoLength: (json['torsoLength'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      bodyType: json['bodyType'] as String,
    );

Map<String, dynamic> _$$BodyMeasurementsImplToJson(
        _$BodyMeasurementsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'chestCircumference': instance.chestCircumference,
      'waistCircumference': instance.waistCircumference,
      'hipCircumference': instance.hipCircumference,
      'inseam': instance.inseam,
      'shoulderWidth': instance.shoulderWidth,
      'armLength': instance.armLength,
      'neckCircumference': instance.neckCircumference,
      'torsoLength': instance.torsoLength,
      'height': instance.height,
      'bodyType': instance.bodyType,
    };
