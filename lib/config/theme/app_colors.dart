import 'package:flutter/material.dart';

/// ThreadSense color palette — dark-first, Apple-meets-Vogue aesthetic.
///
/// All colors should be referenced through this class. Never use
/// hardcoded color literals in widget code.
class AppColors {
  AppColors._();

  // ─── Primary Palette (Warm Gold / Champagne) ───────────────────────
  static const Color primaryGold = Color(0xFFC9A96E);
  static const Color primaryGoldLight = Color(0xFFE8D5A8);
  static const Color primaryGoldDark = Color(0xFF8B7340);

  // ─── Background (True Dark) ────────────────────────────────────────
  static const Color backgroundPrimary = Color(0xFF0A0A0A);
  static const Color backgroundCard = Color(0xFF141414);
  static const Color backgroundElevated = Color(0xFF1A1A1A);
  static const Color backgroundSheet = Color(0xFF1E1E1E);

  // ─── Surface / Glass ───────────────────────────────────────────────
  static Color surfaceGlass = Colors.white.withValues(alpha: 0.06);
  static Color surfaceBorder = Colors.white.withValues(alpha: 0.10);
  static Color surfaceHover = Colors.white.withValues(alpha: 0.08);

  // ─── Text ──────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFFA0A0A0);
  static const Color textTertiary = Color(0xFF666666);

  // ─── Accents ───────────────────────────────────────────────────────
  static const Color accentSuccess = Color(0xFF4ADE80);
  static const Color accentError = Color(0xFFF87171);
  static const Color accentWarning = Color(0xFFFBBF24);
  static const Color accentInfo = Color(0xFF60A5FA);

  // ─── Gradients ─────────────────────────────────────────────────────
  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [primaryGold, primaryGoldDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientPremium = LinearGradient(
    colors: [primaryGold, primaryGoldLight, primaryGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientDark = LinearGradient(
    colors: [backgroundPrimary, backgroundElevated],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Overlay gradient for cards with text at the bottom.
  static LinearGradient get gradientCardOverlay => LinearGradient(
    colors: [
      Colors.transparent,
      Colors.black.withValues(alpha: 0.70),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.3, 1.0],
  );
}
