import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';

/// Cart Screen
/// Displays the user's shopping cart items
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MEColors.background,
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: METextStyles.h2,
        ),
        backgroundColor: MEColors.cardBackground,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Cart Screen',
          style: METextStyles.h3,
        ),
      ),
    );
  }
} 