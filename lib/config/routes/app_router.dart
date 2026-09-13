import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/feed/screens/style_feed_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/onboarding/screens/permissions_screen.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/product/screens/product_detail_screen.dart';
import '../../features/profile/screens/body_profile_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/scanning/screens/body_scan_screen.dart';
import '../../features/scanning/screens/scan_preparation_screen.dart';
import '../../features/scanning/screens/scan_results_screen.dart';
import '../../core/widgets/bottom_nav_bar.dart';

/// Route path constants to avoid magic strings.
class RoutePaths {
  RoutePaths._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String permissions = '/permissions';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String scanPrepare = '/scan/prepare';
  static const String scanCapture = '/scan/capture';
  static const String scanResults = '/scan/results';
  static const String feed = '/feed';
  static const String profile = '/profile';
  static const String bodyProfile = '/profile/body';
  static const String productDetail = '/product/:id';
}

/// The global [GoRouter] configuration.
///
/// Uses a [ShellRoute] to wrap the main tabs (Feed, Profile) with
/// a persistent [BottomNavBar].
final appRouter = GoRouter(
  initialLocation: RoutePaths.splash,
  debugLogDiagnostics: true,
  routes: [
    // ── Unauthenticated routes ─────────────────────────────────────
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePaths.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RoutePaths.permissions,
      builder: (context, state) => const PermissionsScreen(),
    ),
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.signup,
      builder: (context, state) => const SignupScreen(),
    ),

    // ── Scan flow (outside shell — full screen, no nav bar) ────────
    GoRoute(
      path: RoutePaths.scanPrepare,
      builder: (context, state) => const ScanPreparationScreen(),
    ),
    GoRoute(
      path: RoutePaths.scanCapture,
      builder: (context, state) => const BodyScanScreen(),
    ),
    GoRoute(
      path: RoutePaths.scanResults,
      builder: (context, state) => const ScanResultsScreen(),
    ),

    // ── Main shell (bottom nav bar) ────────────────────────────────
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithBottomNav(child: child);
      },
      routes: [
        GoRoute(
          path: RoutePaths.feed,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: StyleFeedScreen(),
          ),
        ),
        GoRoute(
          path: RoutePaths.profile,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
          routes: [
            GoRoute(
              path: 'body',
              builder: (context, state) => const BodyProfileScreen(),
            ),
          ],
        ),
      ],
    ),

    // ── Product detail (outside shell — full screen) ───────────────
    GoRoute(
      path: RoutePaths.productDetail,
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        return ProductDetailScreen(productId: productId);
      },
    ),
  ],
);

/// Scaffold wrapper that adds the persistent [BottomNavBar] to
/// shell routes.
class ScaffoldWithBottomNav extends StatelessWidget {
  const ScaffoldWithBottomNav({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
