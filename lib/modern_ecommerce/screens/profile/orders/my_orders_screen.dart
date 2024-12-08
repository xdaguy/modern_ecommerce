import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/base_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/profile/orders/order_details_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/profile/orders/order_tracking_screen.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'My Orders',
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Dummy count
        itemBuilder: (context, index) {
          return _buildOrderCard(
            context,
            orderId: 'ME${1000 + index}',
            date: 'June 15, 2024',
            items: 3,
            total: 229.98,
            status: index == 0 ? 'Delivered' : 'In Transit',
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String orderId,
    required String date,
    required int items,
    required double total,
    required String status,
  }) {
    final isDelivered = status == 'Delivered';

    return Container(
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
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Text(
                  'Order #$orderId',
                  style: METextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isDelivered
                        ? MEColors.success.withOpacity(0.1)
                        : MEColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: isDelivered ? MEColors.success : MEColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text('$items items • \$${total.toStringAsFixed(2)}'),
                Text(
                  date,
                  style: TextStyle(
                    color: MEColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderTrackingScreen(
                            orderId: orderId,
                          ),
                        ),
                      );
                    },
                    child: const Text('Track Order'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen(
                            orderId: orderId,
                          ),
                        ),
                      );
                    },
                    child: const Text('View Details'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 