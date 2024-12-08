import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';

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
            // Order Status
            Container(
              padding: const EdgeInsets.all(16),
              color: MEColors.cardBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Order Status', style: METextStyles.h3),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: MEColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Delivered',
                          style: TextStyle(
                            color: MEColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'on June 15, 2024',
                        style: TextStyle(
                          color: MEColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Order Items
            Container(
              padding: const EdgeInsets.all(16),
              color: MEColors.cardBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Items', style: METextStyles.h3),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return _buildOrderItem();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Shipping Details
            Container(
              padding: const EdgeInsets.all(16),
              color: MEColors.cardBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Shipping Details', style: METextStyles.h3),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe\n123 Main Street\nNew York, NY 10001\n+1 234 567 890',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Payment Details
            Container(
              padding: const EdgeInsets.all(16),
              color: MEColors.cardBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Payment Details', style: METextStyles.h3),
                  const SizedBox(height: 16),
                  _buildPaymentRow('Payment Method', 'Visa •••• 4242'),
                  const SizedBox(height: 8),
                  _buildPaymentRow('Subtotal', '\$199.98'),
                  const SizedBox(height: 8),
                  _buildPaymentRow('Shipping', '\$10.00'),
                  const SizedBox(height: 8),
                  _buildPaymentRow('Tax', '\$20.00'),
                  const Divider(height: 24),
                  _buildPaymentRow('Total', '\$229.98', isTotal: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/200',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Product Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Size: M | Color: Blue',
                  style: TextStyle(
                    color: MEColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$99.99',
                      style: TextStyle(
                        color: MEColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Qty: 1',
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
      ),
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