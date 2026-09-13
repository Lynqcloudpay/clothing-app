import 'package:flutter/material.dart';
import '../../../core/widgets/gradient_button.dart';

class PurchaseButton extends StatelessWidget {
  final double price;
  final VoidCallback onPressed;

  const PurchaseButton({super.key, required this.price, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      label: 'Buy Now - \$${price.toStringAsFixed(2)}',
      onPressed: onPressed,
      icon: Icons.shopping_bag_outlined,
    );
  }
}
