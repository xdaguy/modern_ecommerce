import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/base_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/product_card.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/dummy_data.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/product/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/wishlist_provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/navigation_provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Wishlist',
      body: Consumer<WishlistProvider>(
        builder: (context, wishlist, child) {
          if (wishlist.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: MEColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your wishlist is empty',
                    style: METextStyles.h3.copyWith(
                      color: MEColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Save items you love to your wishlist',
                    style: METextStyles.bodyMedium.copyWith(
                      color: MEColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<NavigationProvider>().setIndex(0);
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Start Shopping'),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: wishlist.items.length,
            itemBuilder: (context, index) {
              final product = wishlist.items[index];
              return ProductCard(
                product: product,
                isInWishlist: true,
                onFavoritePressed: () {
                  context.read<WishlistProvider>().toggleWishlist(product);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        product: product,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
} 