// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_scan_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BodyScanSessionImpl _$$BodyScanSessionImplFromJson(
        Map<String, dynamic> json) =>
    _$BodyScanSessionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      status: $enumDecodeNullable(_$ScanStatusEnumMap, json['status']) ??
          ScanStatus.preparing,
      scanProgress: (json['scanProgress'] as num?)?.toDouble() ?? 0.0,
      meshFilePath: json['meshFilePath'] as String?,
      errorMessage: json['errorMessage'] as String?,
      measurements: json['measurements'] == null
          ? null
          : BodyMeasurements.fromJson(
              json['measurements'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BodyScanSessionImplToJson(
        _$BodyScanSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'status': _$ScanStatusEnumMap[instance.status]!,
      'scanProgress': instance.scanProgress,
      'meshFilePath': instance.meshFilePath,
      'errorMessage': instance.errorMessage,
      'measurements': instance.measurements,
    };

const _$ScanStatusEnumMap = {
  ScanStatus.preparing: 'preparing',
  ScanStatus.scanning: 'scanning',
  ScanStatus.processing: 'processing',
  ScanStatus.completed: 'completed',
  ScanStatus.failed: 'failed',
};
