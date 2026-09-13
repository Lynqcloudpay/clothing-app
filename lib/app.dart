import 'package:flutter/material.dart';

import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';

/// Root [MaterialApp] for ThreadSense.
///
/// Uses [MaterialApp.router] with the GoRouter configuration and
/// the dark theme. A [builder] clamps text scaling to keep layouts
/// consistent on devices with extreme accessibility settings.
class ThreadSenseApp extends StatelessWidget {
  const ThreadSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ThreadSense',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
      builder: (context, child) {
        // Clamp text scaling to prevent layout breakage at extreme
        // accessibility settings while still respecting user preference.
        final mediaQuery = MediaQuery.of(context);
        final clampedTextScaler = mediaQuery.textScaler.clamp(
          minScaleFactor: 0.8,
          maxScaleFactor: 1.3,
        );
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: clampedTextScaler),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
