import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/dummy_data.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/search_bar.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/category_grid_card.dart';

/// Categories Screen
/// Displays all product categories in a grid view
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MEColors.background,
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: METextStyles.h2,
        ),
        backgroundColor: MEColors.cardBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: MEColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: MESearchBar(
              hintText: 'Search categories...',
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: dummyCategories.length,
              itemBuilder: (context, index) {
                return CategoryGridCard(
                  category: dummyCategories[index],
                  onTap: () {
                    // Navigate to category products
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 