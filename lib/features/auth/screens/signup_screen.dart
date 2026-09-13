import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../config/constants/app_strings.dart';
import '../../../core/widgets/gradient_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_login_button.dart';

/// Signup screen — mirrors the login screen structure.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Firebase Auth — createUserWithEmailAndPassword
      await Future.delayed(const Duration(seconds: 1)); // Placeholder
      if (mounted) context.go(RoutePaths.feed);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.xxl),

              // ── Logo ─────────────────────────────────────────
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: AppColors.gradientPrimary,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.borderRadiusLg),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.backgroundPrimary,
                  size: 32,
                ),
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: AppSpacing.md),

              Text(
                AppStrings.appName,
                style: AppTypography.headlineLarge.copyWith(
                  color: AppColors.primaryGold,
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

              const SizedBox(height: AppSpacing.xl),

              // ── Title ────────────────────────────────────────
              Text(
                AppStrings.signupTitle,
                style: AppTypography.displayMedium,
              ).animate().fadeIn(duration: 400.ms, delay: 200.ms),

              const SizedBox(height: AppSpacing.xl),

              // ── Form ─────────────────────────────────────────
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _emailController,
                      hint: AppStrings.emailHint,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      controller: _passwordController,
                      hint: AppStrings.passwordHint,
                      prefixIcon: Icons.lock_outline_rounded,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      controller: _confirmPasswordController,
                      hint: AppStrings.confirmPasswordHint,
                      prefixIcon: Icons.lock_outline_rounded,
                      isPassword: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 300.ms),

              const SizedBox(height: AppSpacing.lg),

              // ── Signup Button ────────────────────────────────
              GradientButton(
                label: AppStrings.signupButton,
                onPressed: _signup,
                isLoading: _isLoading,
              ).animate().fadeIn(duration: 400.ms, delay: 400.ms),

              const SizedBox(height: AppSpacing.lg),

              // ── Divider ──────────────────────────────────────
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.surfaceBorder)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: Text(
                      AppStrings.orContinueWith,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.surfaceBorder)),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              // ── Social Login ─────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: SocialLoginButton(
                      label: 'Google',
                      icon: Icons.g_mobiledata_rounded,
                      onPressed: () {
                        // TODO: Google Sign-In
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: SocialLoginButton(
                      label: 'Apple',
                      icon: Icons.apple_rounded,
                      onPressed: () {
                        // TODO: Apple Sign-In
                      },
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms, delay: 500.ms),

              const SizedBox(height: AppSpacing.xl),

              // ── Login toggle ─────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.hasAccount,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go(RoutePaths.login),
                    child: Text(
                      AppStrings.logIn,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
