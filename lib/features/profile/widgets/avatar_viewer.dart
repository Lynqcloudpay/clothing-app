import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class AvatarViewer extends StatelessWidget {
  const AvatarViewer({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real implementation this would use model_viewer_plus
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: AppColors.backgroundElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryGold.withValues(alpha: 0.3)),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.threed_rotation, size: 60, color: AppColors.primaryGold),
            SizedBox(height: 16),
            Text('Interactive 3D Avatar View', style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
