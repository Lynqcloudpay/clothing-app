import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_typography.dart';
import '../../../core/models/body_scan_session.dart';

class VoicePromptBubble extends StatelessWidget {
  final ScanStatus status;

  const VoicePromptBubble({super.key, required this.status});

  String get _prompt {
    switch (status) {
      case ScanStatus.preparing: return 'Step into the outline and stand naturally';
      case ScanStatus.scanning: return 'Hold still... capturing view';
      case ScanStatus.processing: return 'Processing your scan...';
      case ScanStatus.completed: return 'Scan complete!';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_prompt.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primaryGold),
      ),
      child: Text(
        _prompt,
        style: AppTypography.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
