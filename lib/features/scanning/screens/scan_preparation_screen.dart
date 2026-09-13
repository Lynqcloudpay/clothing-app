import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../config/constants/app_strings.dart';
import '../../../core/providers/scan_provider.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';

class ScanPreparationScreen extends ConsumerStatefulWidget {
  const ScanPreparationScreen({super.key});

  @override
  ConsumerState<ScanPreparationScreen> createState() =>
      _ScanPreparationScreenState();
}

class _ScanPreparationScreenState extends ConsumerState<ScanPreparationScreen> {
  late final TextEditingController _cmController;
  late final TextEditingController _feetController;
  late final TextEditingController _inchesController;
  bool _useImperial = false;

  @override
  void initState() {
    super.initState();
    final cm = ref.read(userHeightCmProvider);
    _cmController = TextEditingController(text: cm.toStringAsFixed(0));
    _feetController =
        TextEditingController(text: (cm / 30.48).floor().toString());
    _inchesController =
        TextEditingController(text: ((cm / 2.54) % 12).round().toString());
  }

  @override
  void dispose() {
    _cmController.dispose();
    _feetController.dispose();
    _inchesController.dispose();
    super.dispose();
  }

  double? _parsedHeightCm() {
    if (_useImperial) {
      final feet = double.tryParse(_feetController.text);
      final inches = double.tryParse(_inchesController.text) ?? 0;
      if (feet == null) return null;
      return feet * 30.48 + inches * 2.54;
    }
    return double.tryParse(_cmController.text);
  }

  void _startScan() {
    final cm = _parsedHeightCm();
    if (cm == null || cm < 120 || cm > 250) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid height (120–250 cm).'),
        ),
      );
      return;
    }
    ref.read(userHeightCmProvider.notifier).state = cm;
    context.go(RoutePaths.scanCapture);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.scanPrepareTitle),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Animated Silhouette Preview ──────────────────
              SizedBox(
                height: 190,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.accessibility_new_rounded,
                        size: 150,
                        color: AppColors.primaryGold.withValues(alpha: 0.2),
                      ),
                      Container(
                        width: 190,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.primaryGold.withValues(alpha: 0.6),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .slideY(
                            begin: -14.0,
                            end: 14.0,
                            duration: 2.seconds,
                            curve: Curves.easeInOut,
                          ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // ── Instructions Checklist ───────────────────────
              _InstructionCard(
                icon: Icons.lightbulb_outline_rounded,
                text: AppStrings.scanInstruction1,
              )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 100.ms)
                  .slideX(begin: -0.05, end: 0),
              const SizedBox(height: AppSpacing.md),
              _InstructionCard(
                icon: Icons.checkroom_rounded,
                text: AppStrings.scanInstruction2,
              )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 200.ms)
                  .slideX(begin: -0.05, end: 0),
              const SizedBox(height: AppSpacing.md),
              _InstructionCard(
                icon: Icons.phone_android_rounded,
                text: AppStrings.scanInstruction3,
              )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 300.ms)
                  .slideX(begin: -0.05, end: 0),
              const SizedBox(height: AppSpacing.md),
              _InstructionCard(
                icon: Icons.threesixty_rounded,
                text: AppStrings.scanInstruction4,
              )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 400.ms)
                  .slideX(begin: -0.05, end: 0),

              const SizedBox(height: AppSpacing.lg),

              // ── Height Input ─────────────────────────────────
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'YOUR HEIGHT',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primaryGold,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(value: false, label: Text('cm')),
                            ButtonSegment(value: true, label: Text('ft/in')),
                          ],
                          selected: {_useImperial},
                          onSelectionChanged: (selection) =>
                              setState(() => _useImperial = selection.first),
                          style: SegmentedButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    if (_useImperial)
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _feetController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Feet',
                                suffixText: 'ft',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: TextField(
                              controller: _inchesController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                labelText: 'Inches',
                                suffixText: 'in',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      TextField(
                        controller: _cmController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Height',
                          suffixText: 'cm',
                          hintText: 'e.g. 175',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'The camera uses your height to calibrate real-world measurements.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 450.ms),

              const SizedBox(height: AppSpacing.lg),

              // ── Start Button ─────────────────────────────────
              GradientButton(
                label: AppStrings.scanStartButton,
                onPressed: _startScan,
              ).animate().fadeIn(duration: 400.ms, delay: 500.ms),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InstructionCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryGold, size: AppSpacing.iconMd),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
