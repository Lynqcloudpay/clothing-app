import 'package:flutter/material.dart';

class ProductImageGallery extends StatelessWidget {
  const ProductImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: double.infinity,
      color: Colors.grey[900],
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.image, size: 100, color: Colors.white24),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('1 / 4', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }
}
