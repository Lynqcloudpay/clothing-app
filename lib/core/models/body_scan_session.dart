import 'package:freezed_annotation/freezed_annotation.dart';

import 'body_measurements.dart';

part 'body_scan_session.freezed.dart';
part 'body_scan_session.g.dart';

enum ScanStatus { preparing, scanning, processing, completed, failed }

@freezed
class BodyScanSession with _$BodyScanSession {
  const factory BodyScanSession({
    required String id,
    required String userId,
    required DateTime startedAt,
    DateTime? completedAt,
    @Default(ScanStatus.preparing) ScanStatus status,
    @Default(0.0) double scanProgress,
    String? meshFilePath,
    String? errorMessage,
    BodyMeasurements? measurements,
  }) = _BodyScanSession;

  factory BodyScanSession.fromJson(Map<String, dynamic> json) =>
      _$BodyScanSessionFromJson(json);
}
