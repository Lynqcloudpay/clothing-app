// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  UserPreferences get preferences => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String email,
      String? displayName,
      String? photoUrl,
      DateTime createdAt,
      UserPreferences preferences});

  $UserPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? createdAt = null,
    Object? preferences = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences,
    ) as $Val);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPreferencesCopyWith<$Res> get preferences {
    return $UserPreferencesCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String? displayName,
      String? photoUrl,
      DateTime createdAt,
      UserPreferences preferences});

  @override
  $UserPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? createdAt = null,
    Object? preferences = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.email,
      this.displayName,
      this.photoUrl,
      required this.createdAt,
      this.preferences = const UserPreferences()});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final UserPreferences preferences;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl, createdAt: $createdAt, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, displayName, photoUrl, createdAt, preferences);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String email,
      final String? displayName,
      final String? photoUrl,
      required final DateTime createdAt,
      final UserPreferences preferences}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get photoUrl;
  @override
  DateTime get createdAt;
  @override
  UserPreferences get preferences;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  List<String> get preferredOccasions => throw _privateConstructorUsedError;
  List<String> get preferredBrands => throw _privateConstructorUsedError;
  List<String> get preferredColors => throw _privateConstructorUsedError;
  double? get budgetMin => throw _privateConstructorUsedError;
  double? get budgetMax => throw _privateConstructorUsedError;
  String get units => throw _privateConstructorUsedError;

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
          UserPreferences value, $Res Function(UserPreferences) then) =
      _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call(
      {List<String> preferredOccasions,
      List<String> preferredBrands,
      List<String> preferredColors,
      double? budgetMin,
      double? budgetMax,
      String units});
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredOccasions = null,
    Object? preferredBrands = null,
    Object? preferredColors = null,
    Object? budgetMin = freezed,
    Object? budgetMax = freezed,
    Object? units = null,
  }) {
    return _then(_value.copyWith(
      preferredOccasions: null == preferredOccasions
          ? _value.preferredOccasions
          : preferredOccasions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredBrands: null == preferredBrands
          ? _value.preferredBrands
          : preferredBrands // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredColors: null == preferredColors
          ? _value.preferredColors
          : preferredColors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budgetMin: freezed == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double?,
      budgetMax: freezed == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double?,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(_$UserPreferencesImpl value,
          $Res Function(_$UserPreferencesImpl) then) =
      __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> preferredOccasions,
      List<String> preferredBrands,
      List<String> preferredColors,
      double? budgetMin,
      double? budgetMax,
      String units});
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
      _$UserPreferencesImpl _value, $Res Function(_$UserPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredOccasions = null,
    Object? preferredBrands = null,
    Object? preferredColors = null,
    Object? budgetMin = freezed,
    Object? budgetMax = freezed,
    Object? units = null,
  }) {
    return _then(_$UserPreferencesImpl(
      preferredOccasions: null == preferredOccasions
          ? _value._preferredOccasions
          : preferredOccasions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredBrands: null == preferredBrands
          ? _value._preferredBrands
          : preferredBrands // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredColors: null == preferredColors
          ? _value._preferredColors
          : preferredColors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budgetMin: freezed == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double?,
      budgetMax: freezed == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double?,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl implements _UserPreferences {
  const _$UserPreferencesImpl(
      {final List<String> preferredOccasions = const [],
      final List<String> preferredBrands = const [],
      final List<String> preferredColors = const [],
      this.budgetMin,
      this.budgetMax,
      this.units = 'cm'})
      : _preferredOccasions = preferredOccasions,
        _preferredBrands = preferredBrands,
        _preferredColors = preferredColors;

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  final List<String> _preferredOccasions;
  @override
  @JsonKey()
  List<String> get preferredOccasions {
    if (_preferredOccasions is EqualUnmodifiableListView)
      return _preferredOccasions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredOccasions);
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
  final double? budgetMin;
  @override
  final double? budgetMax;
  @override
  @JsonKey()
  final String units;

  @override
  String toString() {
    return 'UserPreferences(preferredOccasions: $preferredOccasions, preferredBrands: $preferredBrands, preferredColors: $preferredColors, budgetMin: $budgetMin, budgetMax: $budgetMax, units: $units)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            const DeepCollectionEquality()
                .equals(other._preferredOccasions, _preferredOccasions) &&
            const DeepCollectionEquality()
                .equals(other._preferredBrands, _preferredBrands) &&
            const DeepCollectionEquality()
                .equals(other._preferredColors, _preferredColors) &&
            (identical(other.budgetMin, budgetMin) ||
                other.budgetMin == budgetMin) &&
            (identical(other.budgetMax, budgetMax) ||
                other.budgetMax == budgetMax) &&
            (identical(other.units, units) || other.units == units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_preferredOccasions),
      const DeepCollectionEquality().hash(_preferredBrands),
      const DeepCollectionEquality().hash(_preferredColors),
      budgetMin,
      budgetMax,
      units);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(
      this,
    );
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences(
      {final List<String> preferredOccasions,
      final List<String> preferredBrands,
      final List<String> preferredColors,
      final double? budgetMin,
      final double? budgetMax,
      final String units}) = _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  @override
  List<String> get preferredOccasions;
  @override
  List<String> get preferredBrands;
  @override
  List<String> get preferredColors;
  @override
  double? get budgetMin;
  @override
  double? get budgetMax;
  @override
  String get units;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
