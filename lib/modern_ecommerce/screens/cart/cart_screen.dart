import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/product.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/dummy_data.dart';
import 'package:provider/provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/cart_provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/navigation_provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/main_layout.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/checkout/checkout_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/utils/route_transitions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          backgroundColor: MEColors.background,
          appBar: AppBar(
            title: Text(
              'Cart (${cart.itemCount})',
              style: METextStyles.h2,
            ),
            actions: [
              if (cart.itemCount > 0)
                TextButton.icon(
                  onPressed: () => _showClearCartDialog(context),
                  icon: const Icon(Icons.delete_outline, size: 20),
                  label: const Text('Clear'),
                ),
            ],
          ),
          body: cart.itemCount == 0
              ? _buildEmptyState(context)
              : Column(
                  children: [
                    Expanded(
                      child: _buildCartList(context, cart),
                    ),
                    _buildOrderSummary(context, cart),
                  ],
                ),
        );
      },
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CartProvider>().clear();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MEColors.error,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: MEColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: MEColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: METextStyles.h3.copyWith(
              color: MEColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to start shopping',
            style: METextStyles.bodyMedium.copyWith(
              color: MEColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
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

  Widget _buildCartList(BuildContext context, CartProvider cart) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cart.itemCount,
      itemBuilder: (context, index) {
        return _buildCartItem(context, cart.items[index]);
      },
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    return Dismissible(
      key: Key(item.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: MEColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.delete_outline,
          color: MEColors.error,
          size: 28,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remove Item'),
            content: Text('Remove ${item.product.name} from cart?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MEColors.error,
                ),
                child: const Text('Remove'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        context.read<CartProvider>().removeItem(item.product.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.product.name} removed from cart'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                context.read<CartProvider>().addItem(item.product);
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: MEColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                child: Image.network(
                  item.product.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Product Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Product Name
                      Text(
                        item.product.name,
                        style: METextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // Price
                      Text(
                        '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                        style: METextStyles.h3.copyWith(
                          color: MEColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Quantity Controls
                      Container(
                        height: 36,
                        decoration: BoxDecoration(
                          border: Border.all(color: MEColors.border),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Decrease Button
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: item.quantity > 1
                                    ? () {
                                        context.read<CartProvider>().updateQuantity(
                                              item.product.id,
                                              item.quantity - 1,
                                            );
                                      }
                                    : null,
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(7),
                                ),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: item.quantity > 1
                                        ? MEColors.textPrimary
                                        : MEColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Quantity Display
                            Container(
                              width: 36,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.symmetric(
                                  horizontal: BorderSide(color: MEColors.border),
                                ),
                              ),
                              child: Text(
                                item.quantity.toString(),
                                style: METextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            
                            // Increase Button
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  context.read<CartProvider>().updateQuantity(
                                        item.product.id,
                                        item.quantity + 1,
                                      );
                                },
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(7),
                                ),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.add,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartProvider cart) {
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
        child: Column(
          children: [
            _buildSummaryRow('Subtotal', cart.subtotal),
            const SizedBox(height: 8),
            _buildSummaryRow('Shipping', cart.shipping),
            const SizedBox(height: 8),
            _buildSummaryRow('Tax', cart.tax),
            const Divider(height: 24),
            _buildSummaryRow('Total', cart.total, isTotal: true),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    SlidePageRoute(
                      page: const CheckoutScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Proceed to Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? METextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)
              : METextStyles.bodyMedium,
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: isTotal
              ? METextStyles.h3.copyWith(color: MEColors.primary)
              : METextStyles.bodyLarge,
        ),
      ],
    );
  }
}
