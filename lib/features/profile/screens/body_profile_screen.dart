import 'package:flutter/material.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../widgets/avatar_viewer.dart';
import '../widgets/measurement_history_chart.dart';
import '../../scanning/widgets/measurement_card.dart';

class BodyProfileScreen extends StatelessWidget {
  const BodyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Body Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Interactive 3D Avatar
            const AvatarViewer(),
            
            const SizedBox(height: AppSpacing.xl),
            
            // Current Measurements
            const Text('Current Measurements', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.md),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 2.5,
              children: const [
                MeasurementCard(icon: Icons.height, label: 'Height', value: '175 cm'),
                MeasurementCard(icon: Icons.fitness_center, label: 'Chest', value: '95 cm'),
                MeasurementCard(icon: Icons.compress, label: 'Waist', value: '80 cm'),
                MeasurementCard(icon: Icons.expand_more, label: 'Hips', value: '100 cm'),
              ],
            ),
            
            const SizedBox(height: AppSpacing.xl),
            
            // History Chart
            const Text('Measurement History', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.md),
            const MeasurementHistoryChart(),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
