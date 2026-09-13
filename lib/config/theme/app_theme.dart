import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// ThreadSense master theme — dark-first, premium aesthetic.
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'PlusJakartaSans',

      // ─── Colors ──────────────────────────────────────────────────
      scaffoldBackgroundColor: AppColors.backgroundPrimary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryGold,
        onPrimary: AppColors.backgroundPrimary,
        secondary: AppColors.primaryGoldLight,
        onSecondary: AppColors.backgroundPrimary,
        surface: AppColors.backgroundCard,
        onSurface: AppColors.textPrimary,
        error: AppColors.accentError,
        onError: AppColors.textPrimary,
      ),

      // ─── App Bar ─────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.titleLarge,
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: AppSpacing.iconMd,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
      ),

      // ─── Card ────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.backgroundCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        ),
        margin: EdgeInsets.zero,
      ),

      // ─── Bottom Navigation ───────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundPrimary,
        selectedItemColor: AppColors.primaryGold,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),

      // ─── Input ───────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          borderSide: BorderSide(color: AppColors.surfaceBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          borderSide: BorderSide(color: AppColors.surfaceBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          borderSide: const BorderSide(
            color: AppColors.primaryGold,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.accentError),
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textTertiary,
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        errorStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.accentError,
        ),
      ),

      // ─── Elevated Button ─────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGold,
          foregroundColor: AppColors.backgroundPrimary,
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          ),
          textStyle: AppTypography.labelLarge.copyWith(
            color: AppColors.backgroundPrimary,
          ),
          elevation: 0,
        ),
      ),

      // ─── Text Button ────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGold,
          textStyle: AppTypography.labelLarge,
        ),
      ),

      // ─── Bottom Sheet ────────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.backgroundSheet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.borderRadiusXl),
          ),
        ),
        showDragHandle: true,
        dragHandleColor: AppColors.textTertiary,
      ),

      // ─── Dialog ──────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.backgroundElevated,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        ),
        titleTextStyle: AppTypography.headlineMedium,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // ─── Snackbar ────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.backgroundElevated,
        contentTextStyle: AppTypography.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // ─── Chip ────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.backgroundElevated,
        selectedColor: AppColors.primaryGold,
        disabledColor: AppColors.backgroundCard,
        labelStyle: AppTypography.bodySmall,
        secondaryLabelStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.backgroundPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusFull),
          side: BorderSide(color: AppColors.surfaceBorder),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),

      // ─── Divider ─────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: AppColors.surfaceBorder,
        thickness: 1,
        space: AppSpacing.lg,
      ),

      // ─── Page Transitions ────────────────────────────────────────
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
