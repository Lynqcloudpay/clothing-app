// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clothing_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClothingItem _$ClothingItemFromJson(Map<String, dynamic> json) {
  return _ClothingItem.fromJson(json);
}

/// @nodoc
mixin _$ClothingItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<String> get additionalImages => throw _privateConstructorUsedError;
  String get category =>
      throw _privateConstructorUsedError; // "tops", "bottoms", "outerwear", "footwear", "accessories"
  String get occasion =>
      throw _privateConstructorUsedError; // "casual", "formal", "activewear", "streetwear"
  String get color => throw _privateConstructorUsedError;
  String get pattern => throw _privateConstructorUsedError;
  String get affiliateUrl => throw _privateConstructorUsedError;
  String get retailer => throw _privateConstructorUsedError;
  Map<String, String> get availableSizes =>
      throw _privateConstructorUsedError; // e.g. {"S": "in_stock"}
  double get trendScore => throw _privateConstructorUsedError;
  DateTime get trendTimestamp => throw _privateConstructorUsedError;

  /// Serializes this ClothingItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClothingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClothingItemCopyWith<ClothingItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClothingItemCopyWith<$Res> {
  factory $ClothingItemCopyWith(
          ClothingItem value, $Res Function(ClothingItem) then) =
      _$ClothingItemCopyWithImpl<$Res, ClothingItem>;
  @useResult
  $Res call(
      {String id,
      String name,
      String brand,
      String description,
      double price,
      String currency,
      String imageUrl,
      List<String> additionalImages,
      String category,
      String occasion,
      String color,
      String pattern,
      String affiliateUrl,
      String retailer,
      Map<String, String> availableSizes,
      double trendScore,
      DateTime trendTimestamp});
}

/// @nodoc
class _$ClothingItemCopyWithImpl<$Res, $Val extends ClothingItem>
    implements $ClothingItemCopyWith<$Res> {
  _$ClothingItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClothingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = null,
    Object? description = null,
    Object? price = null,
    Object? currency = null,
    Object? imageUrl = null,
    Object? additionalImages = null,
    Object? category = null,
    Object? occasion = null,
    Object? color = null,
    Object? pattern = null,
    Object? affiliateUrl = null,
    Object? retailer = null,
    Object? availableSizes = null,
    Object? trendScore = null,
    Object? trendTimestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      additionalImages: null == additionalImages
          ? _value.additionalImages
          : additionalImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      occasion: null == occasion
          ? _value.occasion
          : occasion // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      affiliateUrl: null == affiliateUrl
          ? _value.affiliateUrl
          : affiliateUrl // ignore: cast_nullable_to_non_nullable
              as String,
      retailer: null == retailer
          ? _value.retailer
          : retailer // ignore: cast_nullable_to_non_nullable
              as String,
      availableSizes: null == availableSizes
          ? _value.availableSizes
          : availableSizes // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      trendScore: null == trendScore
          ? _value.trendScore
          : trendScore // ignore: cast_nullable_to_non_nullable
              as double,
      trendTimestamp: null == trendTimestamp
          ? _value.trendTimestamp
          : trendTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClothingItemImplCopyWith<$Res>
    implements $ClothingItemCopyWith<$Res> {
  factory _$$ClothingItemImplCopyWith(
          _$ClothingItemImpl value, $Res Function(_$ClothingItemImpl) then) =
      __$$ClothingItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String brand,
      String description,
      double price,
      String currency,
      String imageUrl,
      List<String> additionalImages,
      String category,
      String occasion,
      String color,
      String pattern,
      String affiliateUrl,
      String retailer,
      Map<String, String> availableSizes,
      double trendScore,
      DateTime trendTimestamp});
}

/// @nodoc
class __$$ClothingItemImplCopyWithImpl<$Res>
    extends _$ClothingItemCopyWithImpl<$Res, _$ClothingItemImpl>
    implements _$$ClothingItemImplCopyWith<$Res> {
  __$$ClothingItemImplCopyWithImpl(
      _$ClothingItemImpl _value, $Res Function(_$ClothingItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClothingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = null,
    Object? description = null,
    Object? price = null,
    Object? currency = null,
    Object? imageUrl = null,
    Object? additionalImages = null,
    Object? category = null,
    Object? occasion = null,
    Object? color = null,
    Object? pattern = null,
    Object? affiliateUrl = null,
    Object? retailer = null,
    Object? availableSizes = null,
    Object? trendScore = null,
    Object? trendTimestamp = null,
  }) {
    return _then(_$ClothingItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      additionalImages: null == additionalImages
          ? _value._additionalImages
          : additionalImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      occasion: null == occasion
          ? _value.occasion
          : occasion // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      affiliateUrl: null == affiliateUrl
          ? _value.affiliateUrl
          : affiliateUrl // ignore: cast_nullable_to_non_nullable
              as String,
      retailer: null == retailer
          ? _value.retailer
          : retailer // ignore: cast_nullable_to_non_nullable
              as String,
      availableSizes: null == availableSizes
          ? _value._availableSizes
          : availableSizes // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      trendScore: null == trendScore
          ? _value.trendScore
          : trendScore // ignore: cast_nullable_to_non_nullable
              as double,
      trendTimestamp: null == trendTimestamp
          ? _value.trendTimestamp
          : trendTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClothingItemImpl implements _ClothingItem {
  const _$ClothingItemImpl(
      {required this.id,
      required this.name,
      required this.brand,
      required this.description,
      required this.price,
      required this.currency,
      required this.imageUrl,
      final List<String> additionalImages = const [],
      required this.category,
      required this.occasion,
      required this.color,
      required this.pattern,
      required this.affiliateUrl,
      required this.retailer,
      final Map<String, String> availableSizes = const {},
      this.trendScore = 0.0,
      required this.trendTimestamp})
      : _additionalImages = additionalImages,
        _availableSizes = availableSizes;

  factory _$ClothingItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClothingItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String brand;
  @override
  final String description;
  @override
  final double price;
  @override
  final String currency;
  @override
  final String imageUrl;
  final List<String> _additionalImages;
  @override
  @JsonKey()
  List<String> get additionalImages {
    if (_additionalImages is EqualUnmodifiableListView)
      return _additionalImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_additionalImages);
  }

  @override
  final String category;
// "tops", "bottoms", "outerwear", "footwear", "accessories"
  @override
  final String occasion;
// "casual", "formal", "activewear", "streetwear"
  @override
  final String color;
  @override
  final String pattern;
  @override
  final String affiliateUrl;
  @override
  final String retailer;
  final Map<String, String> _availableSizes;
  @override
  @JsonKey()
  Map<String, String> get availableSizes {
    if (_availableSizes is EqualUnmodifiableMapView) return _availableSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_availableSizes);
  }

// e.g. {"S": "in_stock"}
  @override
  @JsonKey()
  final double trendScore;
  @override
  final DateTime trendTimestamp;

  @override
  String toString() {
    return 'ClothingItem(id: $id, name: $name, brand: $brand, description: $description, price: $price, currency: $currency, imageUrl: $imageUrl, additionalImages: $additionalImages, category: $category, occasion: $occasion, color: $color, pattern: $pattern, affiliateUrl: $affiliateUrl, retailer: $retailer, availableSizes: $availableSizes, trendScore: $trendScore, trendTimestamp: $trendTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClothingItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._additionalImages, _additionalImages) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.occasion, occasion) ||
                other.occasion == occasion) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.pattern, pattern) || other.pattern == pattern) &&
            (identical(other.affiliateUrl, affiliateUrl) ||
                other.affiliateUrl == affiliateUrl) &&
            (identical(other.retailer, retailer) ||
                other.retailer == retailer) &&
            const DeepCollectionEquality()
                .equals(other._availableSizes, _availableSizes) &&
            (identical(other.trendScore, trendScore) ||
                other.trendScore == trendScore) &&
            (identical(other.trendTimestamp, trendTimestamp) ||
                other.trendTimestamp == trendTimestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      brand,
      description,
      price,
      currency,
      imageUrl,
      const DeepCollectionEquality().hash(_additionalImages),
      category,
      occasion,
      color,
      pattern,
      affiliateUrl,
      retailer,
      const DeepCollectionEquality().hash(_availableSizes),
      trendScore,
      trendTimestamp);

  /// Create a copy of ClothingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClothingItemImplCopyWith<_$ClothingItemImpl> get copyWith =>
      __$$ClothingItemImplCopyWithImpl<_$ClothingItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClothingItemImplToJson(
      this,
    );
  }
}

abstract class _ClothingItem implements ClothingItem {
  const factory _ClothingItem(
      {required final String id,
      required final String name,
      required final String brand,
      required final String description,
      required final double price,
      required final String currency,
      required final String imageUrl,
      final List<String> additionalImages,
      required final String category,
      required final String occasion,
      required final String color,
      required final String pattern,
      required final String affiliateUrl,
      required final String retailer,
      final Map<String, String> availableSizes,
      final double trendScore,
      required final DateTime trendTimestamp}) = _$ClothingItemImpl;

  factory _ClothingItem.fromJson(Map<String, dynamic> json) =
      _$ClothingItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get brand;
  @override
  String get description;
  @override
  double get price;
  @override
  String get currency;
  @override
  String get imageUrl;
  @override
  List<String> get additionalImages;
  @override
  String
      get category; // "tops", "bottoms", "outerwear", "footwear", "accessories"
  @override
  String get occasion; // "casual", "formal", "activewear", "streetwear"
  @override
  String get color;
  @override
  String get pattern;
  @override
  String get affiliateUrl;
  @override
  String get retailer;
  @override
  Map<String, String> get availableSizes; // e.g. {"S": "in_stock"}
  @override
  double get trendScore;
  @override
  DateTime get trendTimestamp;

  /// Create a copy of ClothingItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClothingItemImplCopyWith<_$ClothingItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
