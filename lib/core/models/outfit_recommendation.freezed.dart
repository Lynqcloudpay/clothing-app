// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outfit_recommendation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OutfitRecommendation _$OutfitRecommendationFromJson(Map<String, dynamic> json) {
  return _OutfitRecommendation.fromJson(json);
}

/// @nodoc
mixin _$OutfitRecommendation {
  String get id => throw _privateConstructorUsedError;
  List<ClothingItem> get items => throw _privateConstructorUsedError;
  double get fitScore => throw _privateConstructorUsedError; // 0.0 - 1.0
  double get styleScore => throw _privateConstructorUsedError; // 0.0 - 1.0
  String get recommendationReason => throw _privateConstructorUsedError;
  String get bodyTypeAdvice => throw _privateConstructorUsedError;
  String get recommendedSize => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;

  /// Serializes this OutfitRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OutfitRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OutfitRecommendationCopyWith<OutfitRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutfitRecommendationCopyWith<$Res> {
  factory $OutfitRecommendationCopyWith(OutfitRecommendation value,
          $Res Function(OutfitRecommendation) then) =
      _$OutfitRecommendationCopyWithImpl<$Res, OutfitRecommendation>;
  @useResult
  $Res call(
      {String id,
      List<ClothingItem> items,
      double fitScore,
      double styleScore,
      String recommendationReason,
      String bodyTypeAdvice,
      String recommendedSize,
      double totalPrice});
}

/// @nodoc
class _$OutfitRecommendationCopyWithImpl<$Res,
        $Val extends OutfitRecommendation>
    implements $OutfitRecommendationCopyWith<$Res> {
  _$OutfitRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutfitRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = null,
    Object? fitScore = null,
    Object? styleScore = null,
    Object? recommendationReason = null,
    Object? bodyTypeAdvice = null,
    Object? recommendedSize = null,
    Object? totalPrice = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ClothingItem>,
      fitScore: null == fitScore
          ? _value.fitScore
          : fitScore // ignore: cast_nullable_to_non_nullable
              as double,
      styleScore: null == styleScore
          ? _value.styleScore
          : styleScore // ignore: cast_nullable_to_non_nullable
              as double,
      recommendationReason: null == recommendationReason
          ? _value.recommendationReason
          : recommendationReason // ignore: cast_nullable_to_non_nullable
              as String,
      bodyTypeAdvice: null == bodyTypeAdvice
          ? _value.bodyTypeAdvice
          : bodyTypeAdvice // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedSize: null == recommendedSize
          ? _value.recommendedSize
          : recommendedSize // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutfitRecommendationImplCopyWith<$Res>
    implements $OutfitRecommendationCopyWith<$Res> {
  factory _$$OutfitRecommendationImplCopyWith(_$OutfitRecommendationImpl value,
          $Res Function(_$OutfitRecommendationImpl) then) =
      __$$OutfitRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<ClothingItem> items,
      double fitScore,
      double styleScore,
      String recommendationReason,
      String bodyTypeAdvice,
      String recommendedSize,
      double totalPrice});
}

/// @nodoc
class __$$OutfitRecommendationImplCopyWithImpl<$Res>
    extends _$OutfitRecommendationCopyWithImpl<$Res, _$OutfitRecommendationImpl>
    implements _$$OutfitRecommendationImplCopyWith<$Res> {
  __$$OutfitRecommendationImplCopyWithImpl(_$OutfitRecommendationImpl _value,
      $Res Function(_$OutfitRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutfitRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = null,
    Object? fitScore = null,
    Object? styleScore = null,
    Object? recommendationReason = null,
    Object? bodyTypeAdvice = null,
    Object? recommendedSize = null,
    Object? totalPrice = null,
  }) {
    return _then(_$OutfitRecommendationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ClothingItem>,
      fitScore: null == fitScore
          ? _value.fitScore
          : fitScore // ignore: cast_nullable_to_non_nullable
              as double,
      styleScore: null == styleScore
          ? _value.styleScore
          : styleScore // ignore: cast_nullable_to_non_nullable
              as double,
      recommendationReason: null == recommendationReason
          ? _value.recommendationReason
          : recommendationReason // ignore: cast_nullable_to_non_nullable
              as String,
      bodyTypeAdvice: null == bodyTypeAdvice
          ? _value.bodyTypeAdvice
          : bodyTypeAdvice // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedSize: null == recommendedSize
          ? _value.recommendedSize
          : recommendedSize // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutfitRecommendationImpl implements _OutfitRecommendation {
  const _$OutfitRecommendationImpl(
      {required this.id,
      required final List<ClothingItem> items,
      required this.fitScore,
      required this.styleScore,
      required this.recommendationReason,
      required this.bodyTypeAdvice,
      required this.recommendedSize,
      required this.totalPrice})
      : _items = items;

  factory _$OutfitRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutfitRecommendationImplFromJson(json);

  @override
  final String id;
  final List<ClothingItem> _items;
  @override
  List<ClothingItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double fitScore;
// 0.0 - 1.0
  @override
  final double styleScore;
// 0.0 - 1.0
  @override
  final String recommendationReason;
  @override
  final String bodyTypeAdvice;
  @override
  final String recommendedSize;
  @override
  final double totalPrice;

  @override
  String toString() {
    return 'OutfitRecommendation(id: $id, items: $items, fitScore: $fitScore, styleScore: $styleScore, recommendationReason: $recommendationReason, bodyTypeAdvice: $bodyTypeAdvice, recommendedSize: $recommendedSize, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutfitRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.fitScore, fitScore) ||
                other.fitScore == fitScore) &&
            (identical(other.styleScore, styleScore) ||
                other.styleScore == styleScore) &&
            (identical(other.recommendationReason, recommendationReason) ||
                other.recommendationReason == recommendationReason) &&
            (identical(other.bodyTypeAdvice, bodyTypeAdvice) ||
                other.bodyTypeAdvice == bodyTypeAdvice) &&
            (identical(other.recommendedSize, recommendedSize) ||
                other.recommendedSize == recommendedSize) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_items),
      fitScore,
      styleScore,
      recommendationReason,
      bodyTypeAdvice,
      recommendedSize,
      totalPrice);

  /// Create a copy of OutfitRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutfitRecommendationImplCopyWith<_$OutfitRecommendationImpl>
      get copyWith =>
          __$$OutfitRecommendationImplCopyWithImpl<_$OutfitRecommendationImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutfitRecommendationImplToJson(
      this,
    );
  }
}

abstract class _OutfitRecommendation implements OutfitRecommendation {
  const factory _OutfitRecommendation(
      {required final String id,
      required final List<ClothingItem> items,
      required final double fitScore,
      required final double styleScore,
      required final String recommendationReason,
      required final String bodyTypeAdvice,
      required final String recommendedSize,
      required final double totalPrice}) = _$OutfitRecommendationImpl;

  factory _OutfitRecommendation.fromJson(Map<String, dynamic> json) =
      _$OutfitRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  List<ClothingItem> get items;
  @override
  double get fitScore; // 0.0 - 1.0
  @override
  double get styleScore; // 0.0 - 1.0
  @override
  String get recommendationReason;
  @override
  String get bodyTypeAdvice;
  @override
  String get recommendedSize;
  @override
  double get totalPrice;

  /// Create a copy of OutfitRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutfitRecommendationImplCopyWith<_$OutfitRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
