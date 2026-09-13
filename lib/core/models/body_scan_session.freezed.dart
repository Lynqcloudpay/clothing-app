// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_scan_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BodyScanSession _$BodyScanSessionFromJson(Map<String, dynamic> json) {
  return _BodyScanSession.fromJson(json);
}

/// @nodoc
mixin _$BodyScanSession {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  ScanStatus get status => throw _privateConstructorUsedError;
  double get scanProgress => throw _privateConstructorUsedError;
  String? get meshFilePath => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  BodyMeasurements? get measurements => throw _privateConstructorUsedError;

  /// Serializes this BodyScanSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BodyScanSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BodyScanSessionCopyWith<BodyScanSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyScanSessionCopyWith<$Res> {
  factory $BodyScanSessionCopyWith(
          BodyScanSession value, $Res Function(BodyScanSession) then) =
      _$BodyScanSessionCopyWithImpl<$Res, BodyScanSession>;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime startedAt,
      DateTime? completedAt,
      ScanStatus status,
      double scanProgress,
      String? meshFilePath,
      String? errorMessage,
      BodyMeasurements? measurements});

  $BodyMeasurementsCopyWith<$Res>? get measurements;
}

/// @nodoc
class _$BodyScanSessionCopyWithImpl<$Res, $Val extends BodyScanSession>
    implements $BodyScanSessionCopyWith<$Res> {
  _$BodyScanSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BodyScanSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? status = null,
    Object? scanProgress = null,
    Object? meshFilePath = freezed,
    Object? errorMessage = freezed,
    Object? measurements = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScanStatus,
      scanProgress: null == scanProgress
          ? _value.scanProgress
          : scanProgress // ignore: cast_nullable_to_non_nullable
              as double,
      meshFilePath: freezed == meshFilePath
          ? _value.meshFilePath
          : meshFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      measurements: freezed == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as BodyMeasurements?,
    ) as $Val);
  }

  /// Create a copy of BodyScanSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BodyMeasurementsCopyWith<$Res>? get measurements {
    if (_value.measurements == null) {
      return null;
    }

    return $BodyMeasurementsCopyWith<$Res>(_value.measurements!, (value) {
      return _then(_value.copyWith(measurements: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BodyScanSessionImplCopyWith<$Res>
    implements $BodyScanSessionCopyWith<$Res> {
  factory _$$BodyScanSessionImplCopyWith(_$BodyScanSessionImpl value,
          $Res Function(_$BodyScanSessionImpl) then) =
      __$$BodyScanSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime startedAt,
      DateTime? completedAt,
      ScanStatus status,
      double scanProgress,
      String? meshFilePath,
      String? errorMessage,
      BodyMeasurements? measurements});

  @override
  $BodyMeasurementsCopyWith<$Res>? get measurements;
}

/// @nodoc
class __$$BodyScanSessionImplCopyWithImpl<$Res>
    extends _$BodyScanSessionCopyWithImpl<$Res, _$BodyScanSessionImpl>
    implements _$$BodyScanSessionImplCopyWith<$Res> {
  __$$BodyScanSessionImplCopyWithImpl(
      _$BodyScanSessionImpl _value, $Res Function(_$BodyScanSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of BodyScanSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? status = null,
    Object? scanProgress = null,
    Object? meshFilePath = freezed,
    Object? errorMessage = freezed,
    Object? measurements = freezed,
  }) {
    return _then(_$BodyScanSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScanStatus,
      scanProgress: null == scanProgress
          ? _value.scanProgress
          : scanProgress // ignore: cast_nullable_to_non_nullable
              as double,
      meshFilePath: freezed == meshFilePath
          ? _value.meshFilePath
          : meshFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      measurements: freezed == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as BodyMeasurements?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BodyScanSessionImpl implements _BodyScanSession {
  const _$BodyScanSessionImpl(
      {required this.id,
      required this.userId,
      required this.startedAt,
      this.completedAt,
      this.status = ScanStatus.preparing,
      this.scanProgress = 0.0,
      this.meshFilePath,
      this.errorMessage,
      this.measurements});

  factory _$BodyScanSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$BodyScanSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  @JsonKey()
  final ScanStatus status;
  @override
  @JsonKey()
  final double scanProgress;
  @override
  final String? meshFilePath;
  @override
  final String? errorMessage;
  @override
  final BodyMeasurements? measurements;

  @override
  String toString() {
    return 'BodyScanSession(id: $id, userId: $userId, startedAt: $startedAt, completedAt: $completedAt, status: $status, scanProgress: $scanProgress, meshFilePath: $meshFilePath, errorMessage: $errorMessage, measurements: $measurements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BodyScanSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scanProgress, scanProgress) ||
                other.scanProgress == scanProgress) &&
            (identical(other.meshFilePath, meshFilePath) ||
                other.meshFilePath == meshFilePath) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.measurements, measurements) ||
                other.measurements == measurements));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      startedAt,
      completedAt,
      status,
      scanProgress,
      meshFilePath,
      errorMessage,
      measurements);

  /// Create a copy of BodyScanSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BodyScanSessionImplCopyWith<_$BodyScanSessionImpl> get copyWith =>
      __$$BodyScanSessionImplCopyWithImpl<_$BodyScanSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BodyScanSessionImplToJson(
      this,
    );
  }
}

abstract class _BodyScanSession implements BodyScanSession {
  const factory _BodyScanSession(
      {required final String id,
      required final String userId,
      required final DateTime startedAt,
      final DateTime? completedAt,
      final ScanStatus status,
      final double scanProgress,
      final String? meshFilePath,
      final String? errorMessage,
      final BodyMeasurements? measurements}) = _$BodyScanSessionImpl;

  factory _BodyScanSession.fromJson(Map<String, dynamic> json) =
      _$BodyScanSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  ScanStatus get status;
  @override
  double get scanProgress;
  @override
  String? get meshFilePath;
  @override
  String? get errorMessage;
  @override
  BodyMeasurements? get measurements;

  /// Create a copy of BodyScanSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BodyScanSessionImplCopyWith<_$BodyScanSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
