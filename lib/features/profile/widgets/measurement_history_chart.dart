import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class MeasurementHistoryChart extends StatelessWidget {
  const MeasurementHistoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real implementation this would use fl_chart
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.show_chart, size: 40, color: AppColors.primaryGold.withValues(alpha: 0.5)),
              const SizedBox(height: 16),
              const Text('Measurement Trend Chart (fl_chart)', style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
      ),
    );
  }
}
