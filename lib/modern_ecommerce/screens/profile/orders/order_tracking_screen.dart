import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MEColors.background,
      appBar: AppBar(
        title: Text('Track Order #$orderId'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Estimated Delivery
            Container(
              padding: const EdgeInsets.all(16),
              color: MEColors.cardBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Estimated Delivery', style: METextStyles.h3),
                  const SizedBox(height: 8),
                  Text(
                    'June 15, 2024',
                    style: TextStyle(
                      color: MEColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Tracking Timeline
            Container(
              padding: const EdgeInsets.all(16),
              color: MEColors.cardBackground,
              child: Column(
                children: [
                  _buildTrackingStep(
                    icon: Icons.check_circle,
                    title: 'Order Confirmed',
                    description: 'Your order has been confirmed',
                    time: '10:00 AM',
                    date: 'June 12, 2024',
                    isCompleted: true,
                    isFirst: true,
                  ),
                  _buildTrackingStep(
                    icon: Icons.inventory_2,
                    title: 'Order Processed',
                    description: 'Your order has been processed',
                    time: '2:30 PM',
                    date: 'June 12, 2024',
                    isCompleted: true,
                  ),
                  _buildTrackingStep(
                    icon: Icons.local_shipping,
                    title: 'Order Shipped',
                    description: 'Your order has been shipped',
                    time: '9:15 AM',
                    date: 'June 13, 2024',
                    isCompleted: true,
                  ),
                  _buildTrackingStep(
                    icon: Icons.location_on,
                    title: 'Out for Delivery',
                    description: 'Your order is out for delivery',
                    time: '8:45 AM',
                    date: 'June 15, 2024',
                    isCompleted: true,
                  ),
                  _buildTrackingStep(
                    icon: Icons.done_all,
                    title: 'Delivered',
                    description: 'Your order has been delivered',
                    time: '2:30 PM',
                    date: 'June 15, 2024',
                    isCompleted: false,
                    isLast: true,
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: MEColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.local_shipping,
                          color: MEColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FedEx Express',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Tracking ID: FX123456789',
                              style: TextStyle(
                                color: MEColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep({
    required IconData icon,
    required String title,
    required String description,
    required String time,
    required String date,
    required bool isCompleted,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? MEColors.primary
                        : MEColors.border.withOpacity(0.5),
                  ),
                  child: Icon(
                    icon,
                    color: isCompleted ? Colors.white : MEColors.textSecondary,
                    size: 20,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted
                          ? MEColors.primary
                          : MEColors.border.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 8,
                bottom: isLast ? 0 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: MEColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$time • $date',
                    style: TextStyle(
                      color: MEColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 