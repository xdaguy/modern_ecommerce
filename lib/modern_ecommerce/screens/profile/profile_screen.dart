import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';

/// Profile Screen
/// Displays user profile information and settings
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MEColors.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: METextStyles.h2,
        ),
        backgroundColor: MEColors.cardBackground,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Profile Screen',
          style: METextStyles.h3,
        ),
      ),
    );
  }
} 