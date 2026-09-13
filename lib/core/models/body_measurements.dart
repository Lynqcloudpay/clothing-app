import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_measurements.freezed.dart';
part 'body_measurements.g.dart';

@freezed
class BodyMeasurements with _$BodyMeasurements {
  const BodyMeasurements._();

  const factory BodyMeasurements({
    required String id,
    required String userId,
    required DateTime createdAt,
    required double chestCircumference,
    required double waistCircumference,
    required double hipCircumference,
    required double inseam,
    required double shoulderWidth,
    required double armLength,
    required double neckCircumference,
    required double torsoLength,
    required double height,
    required String bodyType, // "rectangle", "triangle", "inverted_triangle", "hourglass", "oval"
  }) = _BodyMeasurements;

  factory BodyMeasurements.fromJson(Map<String, dynamic> json) =>
      _$BodyMeasurementsFromJson(json);

  String get sizeUS {
    // TODO: Implement realistic US sizing mapping based on measurements
    if (chestCircumference < 86) return 'XS';
    if (chestCircumference < 96) return 'S';
    if (chestCircumference < 106) return 'M';
    if (chestCircumference < 116) return 'L';
    if (chestCircumference < 126) return 'XL';
    return 'XXL';
  }

  String get sizeEU {
    // TODO: Implement realistic EU sizing mapping
    if (chestCircumference < 86) return '44';
    if (chestCircumference < 96) return '48';
    if (chestCircumference < 106) return '50';
    if (chestCircumference < 116) return '54';
    if (chestCircumference < 126) return '58';
    return '62';
  }

  Map<String, String> get brandSizes {
    // TODO: Implement per-brand mappings
    return {
      'Nike': sizeUS,
      'Zara': sizeEU,
    };
  }
}
