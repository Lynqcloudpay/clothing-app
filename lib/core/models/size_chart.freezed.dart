// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'size_chart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SizeChart _$SizeChartFromJson(Map<String, dynamic> json) {
  return _SizeChart.fromJson(json);
}

/// @nodoc
mixin _$SizeChart {
  String get brand => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  Map<String, SizeRange> get sizes => throw _privateConstructorUsedError;

  /// Serializes this SizeChart to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SizeChart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SizeChartCopyWith<SizeChart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SizeChartCopyWith<$Res> {
  factory $SizeChartCopyWith(SizeChart value, $Res Function(SizeChart) then) =
      _$SizeChartCopyWithImpl<$Res, SizeChart>;
  @useResult
  $Res call(
      {String brand,
      String category,
      String gender,
      Map<String, SizeRange> sizes});
}

/// @nodoc
class _$SizeChartCopyWithImpl<$Res, $Val extends SizeChart>
    implements $SizeChartCopyWith<$Res> {
  _$SizeChartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SizeChart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = null,
    Object? category = null,
    Object? gender = null,
    Object? sizes = null,
  }) {
    return _then(_value.copyWith(
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      sizes: null == sizes
          ? _value.sizes
          : sizes // ignore: cast_nullable_to_non_nullable
              as Map<String, SizeRange>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SizeChartImplCopyWith<$Res>
    implements $SizeChartCopyWith<$Res> {
  factory _$$SizeChartImplCopyWith(
          _$SizeChartImpl value, $Res Function(_$SizeChartImpl) then) =
      __$$SizeChartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String brand,
      String category,
      String gender,
      Map<String, SizeRange> sizes});
}

/// @nodoc
class __$$SizeChartImplCopyWithImpl<$Res>
    extends _$SizeChartCopyWithImpl<$Res, _$SizeChartImpl>
    implements _$$SizeChartImplCopyWith<$Res> {
  __$$SizeChartImplCopyWithImpl(
      _$SizeChartImpl _value, $Res Function(_$SizeChartImpl) _then)
      : super(_value, _then);

  /// Create a copy of SizeChart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = null,
    Object? category = null,
    Object? gender = null,
    Object? sizes = null,
  }) {
    return _then(_$SizeChartImpl(
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      sizes: null == sizes
          ? _value._sizes
          : sizes // ignore: cast_nullable_to_non_nullable
              as Map<String, SizeRange>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SizeChartImpl implements _SizeChart {
  const _$SizeChartImpl(
      {required this.brand,
      required this.category,
      required this.gender,
      required final Map<String, SizeRange> sizes})
      : _sizes = sizes;

  factory _$SizeChartImpl.fromJson(Map<String, dynamic> json) =>
      _$$SizeChartImplFromJson(json);

  @override
  final String brand;
  @override
  final String category;
  @override
  final String gender;
  final Map<String, SizeRange> _sizes;
  @override
  Map<String, SizeRange> get sizes {
    if (_sizes is EqualUnmodifiableMapView) return _sizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sizes);
  }

  @override
  String toString() {
    return 'SizeChart(brand: $brand, category: $category, gender: $gender, sizes: $sizes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SizeChartImpl &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality().equals(other._sizes, _sizes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, brand, category, gender,
      const DeepCollectionEquality().hash(_sizes));

  /// Create a copy of SizeChart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SizeChartImplCopyWith<_$SizeChartImpl> get copyWith =>
      __$$SizeChartImplCopyWithImpl<_$SizeChartImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SizeChartImplToJson(
      this,
    );
  }
}

abstract class _SizeChart implements SizeChart {
  const factory _SizeChart(
      {required final String brand,
      required final String category,
      required final String gender,
      required final Map<String, SizeRange> sizes}) = _$SizeChartImpl;

  factory _SizeChart.fromJson(Map<String, dynamic> json) =
      _$SizeChartImpl.fromJson;

  @override
  String get brand;
  @override
  String get category;
  @override
  String get gender;
  @override
  Map<String, SizeRange> get sizes;

  /// Create a copy of SizeChart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SizeChartImplCopyWith<_$SizeChartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SizeRange _$SizeRangeFromJson(Map<String, dynamic> json) {
  return _SizeRange.fromJson(json);
}

/// @nodoc
mixin _$SizeRange {
  double get chestMin => throw _privateConstructorUsedError;
  double get chestMax => throw _privateConstructorUsedError;
  double get waistMin => throw _privateConstructorUsedError;
  double get waistMax => throw _privateConstructorUsedError;
  double get hipMin => throw _privateConstructorUsedError;
  double get hipMax => throw _privateConstructorUsedError;

  /// Serializes this SizeRange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SizeRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SizeRangeCopyWith<SizeRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SizeRangeCopyWith<$Res> {
  factory $SizeRangeCopyWith(SizeRange value, $Res Function(SizeRange) then) =
      _$SizeRangeCopyWithImpl<$Res, SizeRange>;
  @useResult
  $Res call(
      {double chestMin,
      double chestMax,
      double waistMin,
      double waistMax,
      double hipMin,
      double hipMax});
}

/// @nodoc
class _$SizeRangeCopyWithImpl<$Res, $Val extends SizeRange>
    implements $SizeRangeCopyWith<$Res> {
  _$SizeRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SizeRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chestMin = null,
    Object? chestMax = null,
    Object? waistMin = null,
    Object? waistMax = null,
    Object? hipMin = null,
    Object? hipMax = null,
  }) {
    return _then(_value.copyWith(
      chestMin: null == chestMin
          ? _value.chestMin
          : chestMin // ignore: cast_nullable_to_non_nullable
              as double,
      chestMax: null == chestMax
          ? _value.chestMax
          : chestMax // ignore: cast_nullable_to_non_nullable
              as double,
      waistMin: null == waistMin
          ? _value.waistMin
          : waistMin // ignore: cast_nullable_to_non_nullable
              as double,
      waistMax: null == waistMax
          ? _value.waistMax
          : waistMax // ignore: cast_nullable_to_non_nullable
              as double,
      hipMin: null == hipMin
          ? _value.hipMin
          : hipMin // ignore: cast_nullable_to_non_nullable
              as double,
      hipMax: null == hipMax
          ? _value.hipMax
          : hipMax // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SizeRangeImplCopyWith<$Res>
    implements $SizeRangeCopyWith<$Res> {
  factory _$$SizeRangeImplCopyWith(
          _$SizeRangeImpl value, $Res Function(_$SizeRangeImpl) then) =
      __$$SizeRangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double chestMin,
      double chestMax,
      double waistMin,
      double waistMax,
      double hipMin,
      double hipMax});
}

/// @nodoc
class __$$SizeRangeImplCopyWithImpl<$Res>
    extends _$SizeRangeCopyWithImpl<$Res, _$SizeRangeImpl>
    implements _$$SizeRangeImplCopyWith<$Res> {
  __$$SizeRangeImplCopyWithImpl(
      _$SizeRangeImpl _value, $Res Function(_$SizeRangeImpl) _then)
      : super(_value, _then);

  /// Create a copy of SizeRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chestMin = null,
    Object? chestMax = null,
    Object? waistMin = null,
    Object? waistMax = null,
    Object? hipMin = null,
    Object? hipMax = null,
  }) {
    return _then(_$SizeRangeImpl(
      chestMin: null == chestMin
          ? _value.chestMin
          : chestMin // ignore: cast_nullable_to_non_nullable
              as double,
      chestMax: null == chestMax
          ? _value.chestMax
          : chestMax // ignore: cast_nullable_to_non_nullable
              as double,
      waistMin: null == waistMin
          ? _value.waistMin
          : waistMin // ignore: cast_nullable_to_non_nullable
              as double,
      waistMax: null == waistMax
          ? _value.waistMax
          : waistMax // ignore: cast_nullable_to_non_nullable
              as double,
      hipMin: null == hipMin
          ? _value.hipMin
          : hipMin // ignore: cast_nullable_to_non_nullable
              as double,
      hipMax: null == hipMax
          ? _value.hipMax
          : hipMax // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SizeRangeImpl implements _SizeRange {
  const _$SizeRangeImpl(
      {required this.chestMin,
      required this.chestMax,
      required this.waistMin,
      required this.waistMax,
      required this.hipMin,
      required this.hipMax});

  factory _$SizeRangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SizeRangeImplFromJson(json);

  @override
  final double chestMin;
  @override
  final double chestMax;
  @override
  final double waistMin;
  @override
  final double waistMax;
  @override
  final double hipMin;
  @override
  final double hipMax;

  @override
  String toString() {
    return 'SizeRange(chestMin: $chestMin, chestMax: $chestMax, waistMin: $waistMin, waistMax: $waistMax, hipMin: $hipMin, hipMax: $hipMax)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SizeRangeImpl &&
            (identical(other.chestMin, chestMin) ||
                other.chestMin == chestMin) &&
            (identical(other.chestMax, chestMax) ||
                other.chestMax == chestMax) &&
            (identical(other.waistMin, waistMin) ||
                other.waistMin == waistMin) &&
            (identical(other.waistMax, waistMax) ||
                other.waistMax == waistMax) &&
            (identical(other.hipMin, hipMin) || other.hipMin == hipMin) &&
            (identical(other.hipMax, hipMax) || other.hipMax == hipMax));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, chestMin, chestMax, waistMin, waistMax, hipMin, hipMax);

  /// Create a copy of SizeRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SizeRangeImplCopyWith<_$SizeRangeImpl> get copyWith =>
      __$$SizeRangeImplCopyWithImpl<_$SizeRangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SizeRangeImplToJson(
      this,
    );
  }
}

abstract class _SizeRange implements SizeRange {
  const factory _SizeRange(
      {required final double chestMin,
      required final double chestMax,
      required final double waistMin,
      required final double waistMax,
      required final double hipMin,
      required final double hipMax}) = _$SizeRangeImpl;

  factory _SizeRange.fromJson(Map<String, dynamic> json) =
      _$SizeRangeImpl.fromJson;

  @override
  double get chestMin;
  @override
  double get chestMax;
  @override
  double get waistMin;
  @override
  double get waistMax;
  @override
  double get hipMin;
  @override
  double get hipMax;

  /// Create a copy of SizeRange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SizeRangeImplCopyWith<_$SizeRangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
