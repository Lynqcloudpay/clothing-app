import 'package:flutter/material.dart';
import '../../../core/widgets/animated_progress_ring.dart';

class ScanProgressIndicator extends StatelessWidget {
  final double progress;

  const ScanProgressIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return AnimatedProgressRing(
      progress: progress,
      size: 80,
      strokeWidth: 4,
    );
  }
}
