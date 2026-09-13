import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_typography.dart';

/// A styled text field for auth forms — dark filled background,
/// gold focus border, prefix icon, and password toggle.
class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: AppTypography.bodyLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: AppColors.primaryGold,
          size: 20,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textTertiary,
                  size: 20,
                ),
                onPressed: () {
                  setState(() => _obscureText = !_obscureText);
                },
              )
            : null,
      ),
    );
  }
}
