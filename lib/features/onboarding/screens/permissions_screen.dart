import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../config/constants/app_strings.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';

/// Permission request screen — camera, motion, and optional microphone.
///
/// Camera + Motion must be granted to continue. Microphone is optional
/// (for voice-guided scanning). Each card is tappable to request the
/// specific permission.
class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  PermissionStatus _cameraStatus = PermissionStatus.denied;
  PermissionStatus _motionStatus = PermissionStatus.denied;
  PermissionStatus _micStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _checkExistingPermissions();
  }

  Future<void> _checkExistingPermissions() async {
    if (kIsWeb) {
      if (mounted) {
        setState(() {
          _cameraStatus = PermissionStatus.granted;
          _motionStatus = PermissionStatus.granted;
          _micStatus = PermissionStatus.granted;
        });
      }
      return;
    }

    final camera = await Permission.camera.status;
    final mic = await Permission.microphone.status;
    final motion = await Permission.sensors.status;

    if (mounted) {
      setState(() {
        _cameraStatus = camera;
        _micStatus = mic;
        _motionStatus = motion;
      });
    }
  }

  Future<void> _requestCamera() async {
    if (kIsWeb) {
      if (mounted) setState(() => _cameraStatus = PermissionStatus.granted);
      return;
    }
    final status = await Permission.camera.request();
    if (mounted) {
      setState(() => _cameraStatus = status);
      if (status.isPermanentlyDenied) _showSettingsSnackbar();
    }
  }

  Future<void> _requestMotion() async {
    if (kIsWeb) {
      if (mounted) setState(() => _motionStatus = PermissionStatus.granted);
      return;
    }
    final status = await Permission.sensors.request();
    if (mounted) {
      setState(() => _motionStatus = status);
      if (status.isPermanentlyDenied) _showSettingsSnackbar();
    }
  }

  Future<void> _requestMicrophone() async {
    if (kIsWeb) {
      if (mounted) setState(() => _micStatus = PermissionStatus.granted);
      return;
    }
    final status = await Permission.microphone.request();
    if (mounted) {
      setState(() => _micStatus = status);
      if (status.isPermanentlyDenied) _showSettingsSnackbar();
    }
  }

  void _showSettingsSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(AppStrings.permDeniedSnackbar),
        action: SnackBarAction(
          label: AppStrings.permOpenSettings,
          textColor: AppColors.primaryGold,
          onPressed: () => openAppSettings(),
        ),
      ),
    );
  }

  bool get _canContinue =>
      kIsWeb ||
      (_cameraStatus.isGranted &&
          (_motionStatus.isGranted || _motionStatus.isLimited));

  void _continue() {
    context.go(RoutePaths.feed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),

              // ── Header ───────────────────────────────────────
              Text(
                AppStrings.permissionsTitle,
                style: AppTypography.headlineLarge,
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: AppSpacing.sm),

              Text(
                AppStrings.permissionsSubtitle,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

              const SizedBox(height: AppSpacing.xl),

              // ── Permission Cards ─────────────────────────────
              _PermissionCard(
                icon: Icons.camera_alt_rounded,
                title: AppStrings.permCamera,
                description: AppStrings.permCameraDesc,
                status: _cameraStatus,
                onTap: _requestCamera,
              ).animate().fadeIn(duration: 400.ms, delay: 200.ms)
                  .slideX(begin: -0.05, end: 0),

              const SizedBox(height: AppSpacing.md),

              _PermissionCard(
                icon: Icons.screen_rotation_rounded,
                title: AppStrings.permMotion,
                description: AppStrings.permMotionDesc,
                status: _motionStatus,
                onTap: _requestMotion,
              ).animate().fadeIn(duration: 400.ms, delay: 300.ms)
                  .slideX(begin: -0.05, end: 0),

              const SizedBox(height: AppSpacing.md),

              _PermissionCard(
                icon: Icons.mic_rounded,
                title: AppStrings.permMicrophone,
                description: AppStrings.permMicrophoneDesc,
                status: _micStatus,
                onTap: _requestMicrophone,
                isOptional: true,
              ).animate().fadeIn(duration: 400.ms, delay: 400.ms)
                  .slideX(begin: -0.05, end: 0),

              const Spacer(),

              // ── Continue ─────────────────────────────────────
              GradientButton(
                label: AppStrings.permContinue,
                onPressed: _canContinue ? _continue : null,
              ).animate().fadeIn(duration: 400.ms, delay: 500.ms),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single permission request card.
class _PermissionCard extends StatelessWidget {
  const _PermissionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.status,
    required this.onTap,
    this.isOptional = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final PermissionStatus status;
  final VoidCallback onTap;
  final bool isOptional;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: status.isGranted ? null : onTap,
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryGold,
              size: AppSpacing.iconMd,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: AppTypography.titleMedium),
                    if (isOptional) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Optional',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // Status indicator
          _StatusDot(status: status),
        ],
      ),
    );
  }
}

/// Small status indicator dot: gray (pending), green (granted), red (denied).
class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status});

  final PermissionStatus status;

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    if (status.isGranted || status.isLimited) {
      color = AppColors.accentSuccess;
      icon = Icons.check_circle_rounded;
    } else if (status.isPermanentlyDenied) {
      color = AppColors.accentError;
      icon = Icons.cancel_rounded;
    } else {
      color = AppColors.textTertiary;
      icon = Icons.circle_outlined;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Icon(
        icon,
        key: ValueKey(status),
        color: color,
        size: 24,
      ),
    );
  }
}
