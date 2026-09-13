import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';

/// An animated circular progress ring with a sweep gradient and
/// percentage text in the center.
///
/// ```dart
/// AnimatedProgressRing(progress: 0.75, size: 120)
/// ```
class AnimatedProgressRing extends StatefulWidget {
  const AnimatedProgressRing({
    super.key,
    required this.progress,
    this.size = 120.0,
    this.strokeWidth = 6.0,
    this.duration = const Duration(milliseconds: 800),
    this.showPercentage = true,
    this.centerChild,
  });

  /// Value between 0.0 and 1.0.
  final double progress;

  /// Outer diameter of the ring.
  final double size;

  /// Thickness of the ring stroke.
  final double strokeWidth;

  /// Duration of the fill animation.
  final Duration duration;

  /// Whether to show the percentage label inside.
  final bool showPercentage;

  /// Optional widget to display in the center instead of percentage.
  final Widget? centerChild;

  @override
  State<AnimatedProgressRing> createState() => _AnimatedProgressRingState();
}

class _AnimatedProgressRingState extends State<AnimatedProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _previousProgress = _animation.value;
      _animation = Tween<double>(
        begin: _previousProgress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final percentage = (_animation.value * 100).round();
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Track (background ring)
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _RingPainter(
                  progress: 1.0,
                  strokeWidth: widget.strokeWidth,
                  color: AppColors.surfaceGlass,
                ),
              ),
              // Progress arc
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _RingPainter(
                  progress: _animation.value,
                  strokeWidth: widget.strokeWidth,
                  gradient: const SweepGradient(
                    startAngle: -math.pi / 2,
                    endAngle: 3 * math.pi / 2,
                    colors: [
                      AppColors.primaryGoldDark,
                      AppColors.primaryGold,
                      AppColors.primaryGoldLight,
                    ],
                  ),
                ),
              ),
              // Center content
              if (widget.centerChild != null)
                widget.centerChild!
              else if (widget.showPercentage)
                Text(
                  '$percentage%',
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.primaryGold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Custom painter that draws a circular arc.
class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    this.color,
    this.gradient,
  });

  final double progress;
  final double strokeWidth;
  final Color? color;
  final Gradient? gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (gradient != null) {
      paint.shader = gradient!.createShader(rect);
    } else if (color != null) {
      paint.color = color!;
    }

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      rect,
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
