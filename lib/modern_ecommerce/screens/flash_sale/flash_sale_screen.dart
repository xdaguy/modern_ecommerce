import 'package:flutter/material.dart';
import 'dart:async';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/dummy_data.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/product_card.dart';
import 'package:provider/provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/wishlist_provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/product/product_detail_screen.dart';

class FlashSaleScreen extends StatefulWidget {
  const FlashSaleScreen({super.key});

  @override
  State<FlashSaleScreen> createState() => _FlashSaleScreenState();
}

class _FlashSaleScreenState extends State<FlashSaleScreen> {
  late DateTime _endTime;
  late Timer _timer;
  Duration _timeLeft = const Duration();

  @override
  void initState() {
    super.initState();
    // Set end time to 24 hours from now
    _endTime = DateTime.now().add(const Duration(hours: 24));
    _updateTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTimer());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimer() {
    final now = DateTime.now();
    if (now.isBefore(_endTime)) {
      setState(() {
        _timeLeft = _endTime.difference(now);
      });
    } else {
      _timer.cancel();
    }
  }

  String _formatNumber(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MEColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar with Timer
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      MEColors.primary,
                      const Color(0xFF8086FF),
                    ],
                  ),
                ),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Flash Sale',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Ends in: ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      _buildTimeBox(_formatNumber(_timeLeft.inHours)),
                      const Text(
                        ':',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      _buildTimeBox(_formatNumber(_timeLeft.inMinutes.remainder(60))),
                      const Text(
                        ':',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      _buildTimeBox(_formatNumber(_timeLeft.inSeconds.remainder(60))),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = dummyProducts[index];
                  final discountedPrice = product.price * 0.5; // 50% off

                  return Stack(
                    children: [
                      ProductCard(
                        product: product,
                        isInWishlist: context.watch<WishlistProvider>().isInWishlist(product.id),
                        onFavoritePressed: () {
                          context.read<WishlistProvider>().toggleWishlist(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.read<WishlistProvider>().isInWishlist(product.id)
                                    ? 'Added to wishlist'
                                    : 'Removed from wishlist',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
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
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: MEColors.error,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            '50% OFF',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                childCount: dummyProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: MEColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
} 