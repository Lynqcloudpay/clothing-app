import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:threadsense/core/services/pose_frame_processor.dart';

/// Builds a synthetic landmark map for a person standing front-on in a
/// 480x640 image: nose at top, ankles at bottom, shoulders/hips centered.
Map<PoseLandmarkType, math.Point<double>> frontPosePoints({
  double shoulderHalfWidth = 60.0,
  double hipHalfWidth = 55.0,
}) {
  math.Point<double> p(double x, double y) => math.Point(x, y);
  return {
    PoseLandmarkType.nose: p(240, 60),
    PoseLandmarkType.leftShoulder: p(240 - shoulderHalfWidth, 180),
    PoseLandmarkType.rightShoulder: p(240 + shoulderHalfWidth, 180),
    PoseLandmarkType.leftHip: p(240 - hipHalfWidth, 400),
    PoseLandmarkType.rightHip: p(240 + hipHalfWidth, 400),
    PoseLandmarkType.leftAnkle: p(220, 600),
    PoseLandmarkType.rightAnkle: p(260, 600),
  };
}

Map<PoseLandmarkType, double> fullLikelihoods(
    Map<PoseLandmarkType, math.Point<double>> points) {
  return {for (final k in points.keys) k: 0.95};
}

PoseBodyMetrics? frontMetrics({
  double heightCm = 175.0,
  double shoulderHalfWidth = 60.0,
  double hipHalfWidth = 55.0,
  double? referenceShoulderPx,
}) {
  final points = frontPosePoints(
    shoulderHalfWidth: shoulderHalfWidth,
    hipHalfWidth: hipHalfWidth,
  );
  return PoseBodyMetrics.fromLandmarkPoints(
    points: points,
    likelihoods: fullLikelihoods(points),
    imageWidth: 480,
    imageHeight: 640,
    rotation: InputImageRotation.rotation0deg,
    mirrorHorizontally: false,
    heightCm: heightCm,
    referenceShoulderPx: referenceShoulderPx,
  );
}

void main() {
  group('PoseBodyMetrics.fromLandmarkPoints', () {
    test('measures shoulder width from landmark geometry, not hardcoded', () {
      final narrow = frontMetrics(shoulderHalfWidth: 50.0)!;
      final wide = frontMetrics(shoulderHalfWidth: 70.0)!;
      // Wider pixel separation must produce a wider cm measurement.
      expect(wide.shoulderWidthCm, greaterThan(narrow.shoulderWidthCm));
      // Sanity: plausible adult shoulder width range.
      expect(wide.shoulderWidthCm, inInclusiveRange(30.0, 70.0));
    });

    test('calibrates pixels to cm using the user height', () {
      final short = frontMetrics(heightCm: 160.0)!;
      final tall = frontMetrics(heightCm: 190.0)!;
      // Same pixels, taller person ⇒ larger cm per pixel.
      expect(tall.shoulderWidthCm, greaterThan(short.shoulderWidthCm));
      expect(
        tall.shoulderWidthCm / short.shoulderWidthCm,
        closeTo(190.0 / 160.0, 0.001),
      );
    });

    test('returns null when core joints are missing', () {
      final points = frontPosePoints();
      points.remove(PoseLandmarkType.leftHip);
      final metrics = PoseBodyMetrics.fromLandmarkPoints(
        points: points,
        likelihoods: fullLikelihoods(points),
        imageWidth: 480,
        imageHeight: 640,
        rotation: InputImageRotation.rotation0deg,
        mirrorHorizontally: false,
        heightCm: 175.0,
      );
      expect(metrics, isNull);
    });

    test('detects full body only when head and feet are visible', () {
      final metrics = frontMetrics()!;
      expect(metrics.fullBodyVisible, isTrue);

      final points = frontPosePoints();
      points.remove(PoseLandmarkType.nose);
      final noHead = PoseBodyMetrics.fromLandmarkPoints(
        points: points,
        likelihoods: fullLikelihoods(points),
        imageWidth: 480,
        imageHeight: 640,
        rotation: InputImageRotation.rotation0deg,
        mirrorHorizontally: false,
        heightCm: 175.0,
      )!;
      expect(noHead.fullBodyVisible, isFalse);
    });

    test('flags sideways turn when shoulders compress vs reference', () {
      // Reference: front view with 120px shoulder separation.
      final sideways = frontMetrics(
        shoulderHalfWidth: 25.0, // 50px separation < 50% of 120px
        referenceShoulderPx: 120.0,
      )!;
      expect(sideways.looksSideways, isTrue);

      final frontal = frontMetrics(
        shoulderHalfWidth: 55.0, // 110px separation > 50% of 120px
        referenceShoulderPx: 120.0,
      )!;
      expect(frontal.looksSideways, isFalse);
    });

    test('derives side depths from the side-view landmark geometry', () {
      // Side view: shoulders collapsed onto the depth axis.
      final metrics = frontMetrics(shoulderHalfWidth: 25.0)!;
      expect(metrics.sideChestDepthCm, greaterThan(0));
      expect(metrics.sideWaistDepthCm, greaterThan(0));
      // Depth must be smaller than the frontal chest width of a front pose.
      final frontal = frontMetrics(shoulderHalfWidth: 60.0)!;
      expect(metrics.sideChestDepthCm, lessThan(frontal.chestWidthCm));
    });

    test('normalizes caliper coordinates into 0..1 display space', () {
      final metrics = frontMetrics()!;
      for (final v in [
        metrics.shoulderY,
        metrics.shoulderLeftX,
        metrics.shoulderRightX,
        metrics.chestY,
        metrics.waistY,
        metrics.hipsY,
        metrics.centerX,
      ]) {
        expect(v, inInclusiveRange(0.0, 1.0));
      }
      expect(metrics.shoulderLeftX, lessThan(metrics.shoulderRightX));
    });
  });
}
