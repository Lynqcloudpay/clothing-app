import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class EnvironmentChecker extends StatelessWidget {
  final bool hasWarning;
  final String warningMessage;

  const EnvironmentChecker({
    super.key,
    this.hasWarning = false,
    this.warningMessage = "It's too dark. Try turning on more lights.",
  });

  @override
  Widget build(BuildContext context) {
    if (!hasWarning) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: AppColors.accentWarning.withValues(alpha: 0.9),
      child: Text(
        warningMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
