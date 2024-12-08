import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/product.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/wishlist_provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/product/write_review_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/chat/product_inquiry_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:async';  // For TimeoutException
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:cross_file/cross_file.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MEColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductInfo(),
                const SizedBox(height: 16),
                _buildQuantitySelector(),
                const SizedBox(height: 16),
                _buildDescription(),
                const SizedBox(height: 16),
                _buildReviews(),
                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: MEColors.cardBackground,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Main Image
            PageView.builder(
              itemCount: 4, // Replace with actual images
              onPageChanged: (index) {
                setState(() {
                  _selectedImageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                );
              },
            ),
            // Image indicators
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedImageIndex == index
                          ? MEColors.primary
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () => _showShareOptions(context),
        ),
        Consumer<WishlistProvider>(
          builder: (context, wishlist, child) {
            final isInWishlist = wishlist.isInWishlist(widget.product.id);
            return IconButton(
              icon: Icon(
                isInWishlist ? Icons.favorite : Icons.favorite_border,
                color: isInWishlist ? MEColors.error : null,
              ),
              onPressed: () {
                wishlist.toggleWishlist(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isInWishlist
                          ? 'Removed from wishlist'
                          : 'Added to wishlist',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: MEColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: MEColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.product.category,
                  style: METextStyles.bodySmall.copyWith(
                    color: MEColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
              const SizedBox(width: 4),
              Text(
                widget.product.rating.toString(),
                style: METextStyles.bodySmall,
              ),
              const SizedBox(width: 4),
              Text(
                '(${widget.product.reviews})',
                style: METextStyles.bodySmall.copyWith(
                  color: MEColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.name,
            style: METextStyles.h2,
          ),
          const SizedBox(height: 8),
          Text(
            '\$${widget.product.price.toStringAsFixed(2)}',
            style: METextStyles.h2.copyWith(
              color: MEColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: MEColors.cardBackground,
      child: Row(
        children: [
          const Text(
            'Quantity',
            style: METextStyles.bodyLarge,
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: MEColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (_quantity > 1) {
                      setState(() {
                        _quantity--;
                      });
                    }
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    _quantity.toString(),
                    style: METextStyles.bodyLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: MEColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: METextStyles.h3,
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.description,
            style: METextStyles.bodyMedium.copyWith(
              color: MEColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: MEColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews (${widget.product.reviews})',
                style: METextStyles.h3,
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See All'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _buildReviewItem();
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WriteReviewScreen(
                    product: widget.product,
                  ),
                ),
              );
            },
            child: const Text('Write a Review'),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/3785079/pexels-photo-3785079.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'John Doe',
                      style: METextStyles.bodyLarge,
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              size: 16,
                              color: index < 4 ? Colors.amber : Colors.grey[300],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '2 days ago',
                          style: METextStyles.bodySmall.copyWith(
                            color: MEColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Great product! The quality is excellent and delivery was fast. Highly recommended!',
            style: METextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MEColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: MEColors.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => DraggableScrollableSheet(
                      initialChildSize: 0.9,
                      minChildSize: 0.5,
                      maxChildSize: 0.95,
                      builder: (context, scrollController) => Container(
                        decoration: const BoxDecoration(
                          color: MEColors.background,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: ProductInquiryScreen(
                          product: widget.product,
                          scrollController: scrollController,
                        ),
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.chat_outlined,
                  color: MEColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: MEColors.cardBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Title
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Share Product',
                      style: METextStyles.h3,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              const Divider(height: 1),

              // Share options
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MEColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.text_snippet_outlined,
                    color: MEColors.primary,
                  ),
                ),
                title: const Text('Share Text Only'),
                subtitle: const Text('Share product details as text'),
                onTap: () {
                  Navigator.pop(context);
                  _shareProduct(context);
                },
              ),
              
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MEColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.image_outlined,
                    color: MEColors.primary,
                  ),
                ),
                title: const Text('Share with Image'),
                subtitle: const Text('Share product details with image'),
                onTap: () {
                  Navigator.pop(context);
                  _shareProductWithImage(context);
                },
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareProductWithImage(BuildContext context) async {
    final product = widget.product;
    
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preparing to share...'),
          duration: Duration(seconds: 1),
        ),
      );

      // Create share text
      final shareText = '''
Check out this amazing product!

${product.name}
Price: \$${product.price.toStringAsFixed(2)}

${product.description}

Get it now on FlutterFusion!
''';

      // Download image
      final response = await http.get(Uri.parse(product.imageUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download image');
      }

      // Save to temp file
      final temp = await getTemporaryDirectory();
      final imagePath = '${temp.path}/share_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File(imagePath);
      await file.writeAsBytes(response.bodyBytes);

      // Share
      await Share.shareXFiles(
        [XFile(file.path)],
        text: shareText,
      );

      // Cleanup
      if (await file.exists()) {
        await file.delete();
      }

    } catch (e) {
      print('Share error: $e');
      if (!context.mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Could not share with image'),
          backgroundColor: MEColors.error,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Try Text Only',
            textColor: Colors.white,
            onPressed: () => _shareProduct(context),
          ),
        ),
      );
    }
  }

  void _shareProduct(BuildContext context) {
    final product = widget.product;
    
    // Create share text
    final shareText = '''
Check out this amazing product!

${product.name}
Price: \$${product.price.toStringAsFixed(2)}

${product.description}

Get it now on FlutterFusion!
''';

    // Show share dialog
    Share.share(
      shareText,
      subject: product.name,
    ).then((_) {
      // Optional: Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thanks for sharing!'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not share the product'),
          backgroundColor: MEColors.error,
        ),
      );
    });
  }
} 