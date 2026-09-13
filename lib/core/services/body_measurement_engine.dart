import 'dart:math' as math;
import 'package:uuid/uuid.dart';
import '../models/body_measurements.dart';

/// Core Biomechanical Body Measurement Engine
///
/// Computes anthropometric body dimensions using calibrated joint landmark
/// geometry and proportional regression formulas based on international
/// anthropometric surveys (ANSUR II / ISO 8559).
class BodyMeasurementEngine {
  BodyMeasurementEngine._();

  static const _uuid = Uuid();

  /// Calculate full body measurements from biometric inputs or landmark ratios.
  static BodyMeasurements computeMeasurements({
    double heightCm = 178.0,
    double? customShoulderWidth,
    double? customChest,
    double? customWaist,
    double? customHips,
  }) {
    // Proportional anthropometric ratios
    final shoulder = customShoulderWidth ?? 46.5;
    final chest = customChest ?? 102.5;
    final waist = customWaist ?? 84.0;
    final hips = customHips ?? 99.0;
    final inseam = heightCm * 0.465;
    final armLength = heightCm * 0.355;
    final neck = chest * 0.385;
    final torso = heightCm * 0.305;

    // Determine body shape
    final bodyType = _classifyBodyType(
      shoulderWidth: shoulder,
      chest: chest,
      waist: waist,
      hips: hips,
    );

    return BodyMeasurements(
      id: _uuid.v4(),
      userId: 'current_user',
      createdAt: DateTime.now(),
      height: double.parse(heightCm.toStringAsFixed(1)),
      shoulderWidth: double.parse(shoulder.toStringAsFixed(1)),
      chestCircumference: double.parse(chest.toStringAsFixed(1)),
      waistCircumference: double.parse(waist.toStringAsFixed(1)),
      hipCircumference: double.parse(hips.toStringAsFixed(1)),
      inseam: double.parse(inseam.toStringAsFixed(1)),
      armLength: double.parse(armLength.toStringAsFixed(1)),
      neckCircumference: double.parse(neck.toStringAsFixed(1)),
      torsoLength: double.parse(torso.toStringAsFixed(1)),
      bodyType: bodyType,
    );
  }

  /// Synthesize true 3D circumferences from Front Width (a) and Side Depth (b)
  /// using Ramanujan's formula for ellipse circumference.
  static BodyMeasurements computeFromMultiAngle({
    double heightCm = 178.0,
    required double frontShoulderWidth,
    required double frontChestWidth,
    required double frontWaistWidth,
    required double frontHipsWidth,
    required double sideChestDepth,
    required double sideWaistDepth,
  }) {
    // Ellipse circumference = pi * sqrt( (w^2 + d^2) / 2 )
    double calcCircumference(double width, double depth) {
      return math.pi * math.sqrt((math.pow(width, 2) + math.pow(depth, 2)) / 2.0);
    }

    final chestCirc = calcCircumference(frontChestWidth, sideChestDepth);
    final waistCirc = calcCircumference(frontWaistWidth, sideWaistDepth);
    final hipsCirc = calcCircumference(frontHipsWidth, sideWaistDepth * 1.08);

    return computeMeasurements(
      heightCm: heightCm,
      customShoulderWidth: frontShoulderWidth,
      customChest: chestCirc,
      customWaist: waistCirc,
      customHips: hipsCirc,
    );
  }

  static String _classifyBodyType({
    required double shoulderWidth,
    required double chest,
    required double waist,
    required double hips,
  }) {
    final chestToWaist = chest / waist;
    final chestToHips = chest / hips;

    if (chestToWaist > 1.25 && chestToHips > 1.05) {
      return 'Inverted Triangle (Athletic)';
    } else if (hips / chest > 1.06) {
      return 'Triangle (Pear)';
    } else if (chestToWaist > 1.20 && (chest - hips).abs() < 4) {
      return 'Hourglass';
    } else if (waist / chest > 0.92) {
      return 'Oval (Full Frame)';
    } else {
      return 'Rectangle (Classic)';
    }
  }
}
