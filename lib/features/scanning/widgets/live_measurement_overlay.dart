import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../core/services/body_framing_analyzer.dart';

enum ScanAngle { front, side, back }

class LiveMeasurementOverlay extends StatefulWidget {
  final ScanAngle currentAngle;
  final double userHeightCm;
  final FrameAnalysisResult? analysisResult;

  const LiveMeasurementOverlay({
    super.key,
    required this.currentAngle,
    required this.userHeightCm,
    this.analysisResult,
  });

  @override
  State<LiveMeasurementOverlay> createState() => _LiveMeasurementOverlayState();
}

class _LiveMeasurementOverlayState extends State<LiveMeasurementOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.analysisResult;
    if (result == null) {
      return const SizedBox.shrink();
    }

    final isAligned = result.hasFullBody;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Dynamic Caliper Lines & Anatomical Guide Painter
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return CustomPaint(
              painter: _DynamicCaliperPainter(
                angle: widget.currentAngle,
                result: result,
                isAligned: isAligned,
                pulse: _pulseController.value,
              ),
            );
          },
        ),

        // 2. Real-Time Dynamic Caliper Metric Badges (attached directly to lines)
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;

            final sh = result.shoulder;
            final ch = result.chest;
            final ws = result.waist;
            final hp = result.hips;

            // Side view: the torso's horizontal extent is its depth, measured
            // from the actual side-view pose — never a faked multiplier.
            final sideChestDepth = result.sideDepths?['chest'];
            final sideWaistDepth = result.sideDepths?['waist'];

            return Stack(
              children: [
                // Shoulder Caliper Tag
                if (widget.currentAngle != ScanAngle.side && sh.isVisible)
                  _CaliperTag(
                    top: (sh.yRatio * h) - 12,
                    left: mathClamp((sh.rightXRatio * w) + 6, 10, w - 130),
                    label: 'SHOULDERS: ${sh.valueCm.toStringAsFixed(1)} cm',
                    isAligned: isAligned,
                  ),

                // Chest Caliper Tag
                if (ch.isVisible)
                  _CaliperTag(
                    top: (ch.yRatio * h) - 12,
                    left: mathClamp((ch.rightXRatio * w) + 6, 10, w - 130),
                    label: widget.currentAngle == ScanAngle.side
                        ? 'CHEST DEPTH: ${(sideChestDepth ?? ch.valueCm).toStringAsFixed(1)} cm'
                        : 'CHEST WIDTH: ${ch.valueCm.toStringAsFixed(1)} cm',
                    isAligned: isAligned,
                  ),

                // Waist Caliper Tag
                if (ws.isVisible)
                  _CaliperTag(
                    top: (ws.yRatio * h) - 12,
                    left: mathClamp((ws.rightXRatio * w) + 6, 10, w - 130),
                    label: widget.currentAngle == ScanAngle.side
                        ? 'WAIST DEPTH: ${(sideWaistDepth ?? ws.valueCm).toStringAsFixed(1)} cm'
                        : 'WAIST WIDTH: ${ws.valueCm.toStringAsFixed(1)} cm',
                    isAligned: isAligned,
                  ),

                // Hips Caliper Tag
                if (widget.currentAngle != ScanAngle.side && hp.isVisible)
                  _CaliperTag(
                    top: (hp.yRatio * h) - 12,
                    left: mathClamp((hp.rightXRatio * w) + 6, 10, w - 130),
                    label: 'HIPS WIDTH: ${hp.valueCm.toStringAsFixed(1)} cm',
                    isAligned: isAligned,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  double mathClamp(double val, double min, double max) {
    if (val < min) return min;
    if (val > max) return max;
    return val;
  }
}

class _CaliperTag extends StatelessWidget {
  final double top;
  final double left;
  final String label;
  final bool isAligned;

  const _CaliperTag({
    required this.top,
    required this.left,
    required this.label,
    required this.isAligned,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isAligned ? Colors.greenAccent : AppColors.primaryGold;

    return Positioned(
      top: top,
      left: left,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.82),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: borderColor.withValues(alpha: 0.3),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: borderColor,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _DynamicCaliperPainter extends CustomPainter {
  final ScanAngle angle;
  final FrameAnalysisResult result;
  final bool isAligned;
  final double pulse;

  _DynamicCaliperPainter({
    required this.angle,
    required this.result,
    required this.isAligned,
    required this.pulse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final primaryColor = isAligned ? Colors.greenAccent : AppColors.primaryGold;

    final caliperLinePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final guidePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.25 + (pulse * 0.15))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final cx = result.centerXRatio * w;

    // 1. Head Guide Oval (if in frame)
    if (result.hasFullBody) {
      final headY = (result.headYRatio ?? 0.15) * h;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(cx, headY), width: 50, height: 65),
        guidePaint,
      );
    }

    // 2. Draw Dynamic Caliper Lines Exactly at Detected Body Landmarks
    final sh = result.shoulder;
    final ch = result.chest;
    final ws = result.waist;
    final hp = result.hips;

    if (angle == ScanAngle.side) {
      // Side Profile: Draw chest & waist depth lines
      if (ch.isVisible) {
        final y = ch.yRatio * h;
        final x1 = ch.leftXRatio * w;
        final x2 = ch.rightXRatio * w;
        canvas.drawLine(Offset(x1, y), Offset(x2, y), caliperLinePaint);
        _drawTicks(canvas, Offset(x1, y), Offset(x2, y), caliperLinePaint);
      }
      if (ws.isVisible) {
        final y = ws.yRatio * h;
        final x1 = ws.leftXRatio * w;
        final x2 = ws.rightXRatio * w;
        canvas.drawLine(Offset(x1, y), Offset(x2, y), caliperLinePaint);
        _drawTicks(canvas, Offset(x1, y), Offset(x2, y), caliperLinePaint);
      }
    } else {
      // Front or Back: Draw Shoulder, Chest, Waist, Hips lines
      if (sh.isVisible) {
        final y = sh.yRatio * h;
        final x1 = sh.leftXRatio * w;
        final x2 = sh.rightXRatio * w;
        canvas.drawLine(Offset(x1, y), Offset(x2, y), caliperLinePaint);
        _drawTicks(canvas, Offset(x1, y), Offset(x2, y), caliperLinePaint);
      }

      if (ch.isVisible) {
        final y = ch.yRatio * h;
        final x1 = ch.leftXRatio * w;
        final x2 = ch.rightXRatio * w;
        canvas.drawLine(Offset(x1, y), Offset(x2, y), caliperLinePaint);
        _drawTicks(canvas, Offset(x1, y), Offset(x2, y), caliperLinePaint);
      }

      if (ws.isVisible) {
        final y = ws.yRatio * h;
        final x1 = ws.leftXRatio * w;
        final x2 = ws.rightXRatio * w;
        canvas.drawLine(Offset(x1, y), Offset(x2, y), caliperLinePaint);
        _drawTicks(canvas, Offset(x1, y), Offset(x2, y), caliperLinePaint);
      }

      if (hp.isVisible) {
        final y = hp.yRatio * h;
        final x1 = hp.leftXRatio * w;
        final x2 = hp.rightXRatio * w;
        canvas.drawLine(Offset(x1, y), Offset(x2, y), caliperLinePaint);
        _drawTicks(canvas, Offset(x1, y), Offset(x2, y), caliperLinePaint);
      }
    }

    // 3. Feet Floor Anchor Line
    if (result.hasFullBody) {
      final feetY = (result.feetYRatio ?? 0.86) * h;
      final footPaint = Paint()
        ..color = isAligned
            ? Colors.greenAccent.withValues(alpha: 0.6)
            : Colors.white24
        ..strokeWidth = 2.0;
      canvas.drawLine(
          Offset(cx - 70, feetY), Offset(cx + 70, feetY), footPaint);
    }
  }

  void _drawTicks(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const tickLen = 8.0;
    canvas.drawLine(
        Offset(p1.dx, p1.dy - tickLen), Offset(p1.dx, p1.dy + tickLen), paint);
    canvas.drawLine(
        Offset(p2.dx, p2.dy - tickLen), Offset(p2.dx, p2.dy + tickLen), paint);
  }

  @override
  bool shouldRepaint(covariant _DynamicCaliperPainter oldDelegate) => true;
}
