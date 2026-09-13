import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes/app_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/theme/app_typography.dart';

/// Custom bottom navigation bar with 3 items:
///   • Feed (grid icon)
///   • Scan (gold circle button — navigates to scan prep)
///   • Profile (user icon)
///
/// The center Scan button is elevated with a gradient background
/// to draw attention as the primary action.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _indexFromLocation(location);

    return Container(
      height: AppSpacing.bottomNavHeight,
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        border: Border(
          top: BorderSide(color: AppColors.surfaceBorder),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // ── Feed ─────────────────────────────────────────────
            _NavItem(
              icon: Icons.grid_view_rounded,
              label: 'Feed',
              isActive: currentIndex == 0,
              onTap: () => context.go(RoutePaths.feed),
            ),

            // ── Scan (center elevated button) ────────────────────
            _ScanButton(
              onTap: () => context.push(RoutePaths.scanPrepare),
            ),

            // ── Profile ──────────────────────────────────────────
            _NavItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              isActive: currentIndex == 2,
              onTap: () => context.go(RoutePaths.profile),
            ),
          ],
        ),
      ),
    );
  }

  int _indexFromLocation(String location) {
    if (location.startsWith('/feed')) return 0;
    if (location.startsWith('/profile')) return 2;
    return -1; // No tab selected (shouldn't happen in shell)
  }
}

/// A single navigation item with icon + label and color transition.
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primaryGold : AppColors.textTertiary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isActive ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  icon,
                  color: color,
                  size: AppSpacing.iconMd,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTypography.labelSmall.copyWith(color: color),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

/// The center scan button — a gold gradient circle with a plus icon.
class _ScanButton extends StatefulWidget {
  const _ScanButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<_ScanButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pulseController.forward(),
      onTapUp: (_) {
        _pulseController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pulseController.reverse(),
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: AppColors.gradientPrimary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGold.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.add_rounded,
            color: AppColors.backgroundPrimary,
            size: 28,
          ),
        ),
      ),
    );
  }
}
