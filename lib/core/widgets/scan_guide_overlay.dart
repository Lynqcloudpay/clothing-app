import 'package:flutter/material.dart';

class ScanGuideOverlay extends StatelessWidget {
  const ScanGuideOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/scan_silhouette.png',
        color: Colors.white.withValues(alpha: 0.3),
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.accessibility_new,
          size: 300,
          color: Colors.white30,
        ),
      ),
    );
  }
}
