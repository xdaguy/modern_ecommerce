import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/network_image.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/order.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/product.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/dummy_data.dart';
import 'package:share_plus/share_plus.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MEColors.background,
      appBar: AppBar(
        title: Text('Order #$orderId'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Order Status Card
            _buildStatusCard(),
            const SizedBox(height: 16),
            
            // Order Items
            _buildOrderItems(),
            const SizedBox(height: 16),
            
            // Shipping Details
            _buildShippingDetails(),
            const SizedBox(height: 16),
            
            // Payment Details
            _buildPaymentDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItems() {
    // Example order items using dummy data
    final orderItems = [
      OrderItem(
        id: '1',
        product: dummyProducts[0],
        quantity: 2,
        price: dummyProducts[0].price,
        size: 'M',
        color: 'Black',
      ),
      OrderItem(
        id: '2',
        product: dummyProducts[1],
        quantity: 1,
        price: dummyProducts[1].price,
        size: 'L',
        color: 'Blue',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      color: MEColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Items',
            style: METextStyles.h3,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderItems.length,
            separatorBuilder: (_, __) => const Divider(height: 24),
            itemBuilder: (context, index) {
              return _buildOrderItem(orderItems[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: MENetworkImage(
            imageUrl: item.product.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        
        // Product Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Size: ${item.size} • Color: ${item.color}',
                style: TextStyle(
                  color: MEColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: MEColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Qty: ${item.quantity}',
                    style: TextStyle(
                      color: MEColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MEColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: MEColors.success.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: MEColors.success,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Delivered',
                  style: METextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'June 15, 2024 at 2:30 PM',
                  style: TextStyle(
                    color: MEColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: MEColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Details',
            style: METextStyles.h3,
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            Icons.person_outline,
            'John Doe',
            '+1 234 567 890',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.location_on_outlined,
            '123 Main Street, Apt 4B',
            'New York, NY 10001',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: MEColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Details',
            style: METextStyles.h3,
          ),
          const SizedBox(height: 16),
          _buildPaymentMethod(),
          const Divider(height: 32),
          _buildPaymentRow('Subtotal', '\$299.97'),
          const SizedBox(height: 8),
          _buildPaymentRow('Shipping', '\$10.00'),
          const SizedBox(height: 8),
          _buildPaymentRow('Tax', '\$29.99'),
          const Divider(height: 24),
          _buildPaymentRow('Total', '\$339.96', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: MEColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: MEColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: MEColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.credit_card,
            color: Colors.blue,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Visa ending in 4242',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Expires 12/24',
                style: TextStyle(
                  color: MEColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? const TextStyle(fontWeight: FontWeight.bold)
              : TextStyle(color: MEColors.textSecondary),
        ),
        Text(
          value,
          style: isTotal
              ? TextStyle(
                  color: MEColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )
              : const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
} 