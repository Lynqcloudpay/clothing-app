// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilterOptions _$FilterOptionsFromJson(Map<String, dynamic> json) {
  return _FilterOptions.fromJson(json);
}

/// @nodoc
mixin _$FilterOptions {
  double? get minBudget => throw _privateConstructorUsedError;
  double? get maxBudget => throw _privateConstructorUsedError;
  List<String> get occasions => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<String> get preferredBrands => throw _privateConstructorUsedError;
  List<String> get preferredColors => throw _privateConstructorUsedError;
  String get sortBy => throw _privateConstructorUsedError;

  /// Serializes this FilterOptions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilterOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterOptionsCopyWith<FilterOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterOptionsCopyWith<$Res> {
  factory $FilterOptionsCopyWith(
          FilterOptions value, $Res Function(FilterOptions) then) =
      _$FilterOptionsCopyWithImpl<$Res, FilterOptions>;
  @useResult
  $Res call(
      {double? minBudget,
      double? maxBudget,
      List<String> occasions,
      List<String> categories,
      List<String> preferredBrands,
      List<String> preferredColors,
      String sortBy});
}

/// @nodoc
class _$FilterOptionsCopyWithImpl<$Res, $Val extends FilterOptions>
    implements $FilterOptionsCopyWith<$Res> {
  _$FilterOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minBudget = freezed,
    Object? maxBudget = freezed,
    Object? occasions = null,
    Object? categories = null,
    Object? preferredBrands = null,
    Object? preferredColors = null,
    Object? sortBy = null,
  }) {
    return _then(_value.copyWith(
      minBudget: freezed == minBudget
          ? _value.minBudget
          : minBudget // ignore: cast_nullable_to_non_nullable
              as double?,
      maxBudget: freezed == maxBudget
          ? _value.maxBudget
          : maxBudget // ignore: cast_nullable_to_non_nullable
              as double?,
      occasions: null == occasions
          ? _value.occasions
          : occasions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredBrands: null == preferredBrands
          ? _value.preferredBrands
          : preferredBrands // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredColors: null == preferredColors
          ? _value.preferredColors
          : preferredColors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilterOptionsImplCopyWith<$Res>
    implements $FilterOptionsCopyWith<$Res> {
  factory _$$FilterOptionsImplCopyWith(
          _$FilterOptionsImpl value, $Res Function(_$FilterOptionsImpl) then) =
      __$$FilterOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? minBudget,
      double? maxBudget,
      List<String> occasions,
      List<String> categories,
      List<String> preferredBrands,
      List<String> preferredColors,
      String sortBy});
}

/// @nodoc
class __$$FilterOptionsImplCopyWithImpl<$Res>
    extends _$FilterOptionsCopyWithImpl<$Res, _$FilterOptionsImpl>
    implements _$$FilterOptionsImplCopyWith<$Res> {
  __$$FilterOptionsImplCopyWithImpl(
      _$FilterOptionsImpl _value, $Res Function(_$FilterOptionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minBudget = freezed,
    Object? maxBudget = freezed,
    Object? occasions = null,
    Object? categories = null,
    Object? preferredBrands = null,
    Object? preferredColors = null,
    Object? sortBy = null,
  }) {
    return _then(_$FilterOptionsImpl(
      minBudget: freezed == minBudget
          ? _value.minBudget
          : minBudget // ignore: cast_nullable_to_non_nullable
              as double?,
      maxBudget: freezed == maxBudget
          ? _value.maxBudget
          : maxBudget // ignore: cast_nullable_to_non_nullable
              as double?,
      occasions: null == occasions
          ? _value._occasions
          : occasions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredBrands: null == preferredBrands
          ? _value._preferredBrands
          : preferredBrands // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredColors: null == preferredColors
          ? _value._preferredColors
          : preferredColors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilterOptionsImpl implements _FilterOptions {
  const _$FilterOptionsImpl(
      {this.minBudget,
      this.maxBudget,
      final List<String> occasions = const [],
      final List<String> categories = const [],
      final List<String> preferredBrands = const [],
      final List<String> preferredColors = const [],
      this.sortBy = 'trending'})
      : _occasions = occasions,
        _categories = categories,
        _preferredBrands = preferredBrands,
        _preferredColors = preferredColors;

  factory _$FilterOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterOptionsImplFromJson(json);

  @override
  final double? minBudget;
  @override
  final double? maxBudget;
  final List<String> _occasions;
  @override
  @JsonKey()
  List<String> get occasions {
    if (_occasions is EqualUnmodifiableListView) return _occasions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_occasions);
  }

  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<String> _preferredBrands;
  @override
  @JsonKey()
  List<String> get preferredBrands {
    if (_preferredBrands is EqualUnmodifiableListView) return _preferredBrands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredBrands);
  }

  final List<String> _preferredColors;
  @override
  @JsonKey()
  List<String> get preferredColors {
    if (_preferredColors is EqualUnmodifiableListView) return _preferredColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredColors);
  }

  @override
  @JsonKey()
  final String sortBy;

  @override
  String toString() {
    return 'FilterOptions(minBudget: $minBudget, maxBudget: $maxBudget, occasions: $occasions, categories: $categories, preferredBrands: $preferredBrands, preferredColors: $preferredColors, sortBy: $sortBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterOptionsImpl &&
            (identical(other.minBudget, minBudget) ||
                other.minBudget == minBudget) &&
            (identical(other.maxBudget, maxBudget) ||
                other.maxBudget == maxBudget) &&
            const DeepCollectionEquality()
                .equals(other._occasions, _occasions) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._preferredBrands, _preferredBrands) &&
            const DeepCollectionEquality()
                .equals(other._preferredColors, _preferredColors) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      minBudget,
      maxBudget,
      const DeepCollectionEquality().hash(_occasions),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_preferredBrands),
      const DeepCollectionEquality().hash(_preferredColors),
      sortBy);

  /// Create a copy of FilterOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterOptionsImplCopyWith<_$FilterOptionsImpl> get copyWith =>
      __$$FilterOptionsImplCopyWithImpl<_$FilterOptionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterOptionsImplToJson(
      this,
    );
  }
}

abstract class _FilterOptions implements FilterOptions {
  const factory _FilterOptions(
      {final double? minBudget,
      final double? maxBudget,
      final List<String> occasions,
      final List<String> categories,
      final List<String> preferredBrands,
      final List<String> preferredColors,
      final String sortBy}) = _$FilterOptionsImpl;

  factory _FilterOptions.fromJson(Map<String, dynamic> json) =
      _$FilterOptionsImpl.fromJson;

  @override
  double? get minBudget;
  @override
  double? get maxBudget;
  @override
  List<String> get occasions;
  @override
  List<String> get categories;
  @override
  List<String> get preferredBrands;
  @override
  List<String> get preferredColors;
  @override
  String get sortBy;

  /// Create a copy of FilterOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterOptionsImplCopyWith<_$FilterOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
