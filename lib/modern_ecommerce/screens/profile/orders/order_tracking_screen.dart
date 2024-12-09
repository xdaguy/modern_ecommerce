import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:share_plus/share_plus.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              Share.share('Track your order #$orderId at FlutterFusion');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Preview (Placeholder)
            Container(
              height: 200,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage('https://images.pexels.com/photos/4386442/pexels-photo-4386442.jpeg?auto=compress&cs=tinysrgb&w=800'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Map overlay gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Location markers
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      children: [
                        _buildLocationMarker(
                          'Warehouse',
                          'New York, NY',
                          Icons.store,
                          MEColors.primary,
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                        ),
                        _buildLocationMarker(
                          'Destination',
                          'Boston, MA',
                          Icons.location_on,
                          MEColors.error,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Estimated Delivery Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MEColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: MEColors.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.access_time,
                      color: MEColors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Estimated Delivery',
                          style: TextStyle(
                            color: MEColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'June 15, 2024 by 8:00 PM',
                          style: TextStyle(
                            color: MEColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tracking Timeline
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MEColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tracking Updates',
                    style: METextStyles.h3,
                  ),
                  const SizedBox(height: 16),
                  _buildTrackingTimeline(),
                ],
              ),
            ),

            // Shipping Details
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MEColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shipping Details',
                    style: METextStyles.h3,
                  ),
                  const SizedBox(height: 16),
                  _buildShippingDetail(
                    'Courier',
                    'FedEx Express',
                    Icons.local_shipping,
                  ),
                  _buildShippingDetail(
                    'Tracking Number',
                    'FX123456789',
                    Icons.qr_code,
                  ),
                  _buildShippingDetail(
                    'Service',
                    'Next Day Delivery',
                    Icons.schedule,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationMarker(String title, String subtitle, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingTimeline() {
    return Column(
      children: [
        _buildTimelineItem(
          'Order Delivered',
          'Your order has been delivered',
          '2:30 PM',
          'June 15, 2024',
          isCompleted: false,
          isLast: true,
        ),
        _buildTimelineItem(
          'Out for Delivery',
          'Package is out for delivery',
          '8:45 AM',
          'June 15, 2024',
          isCompleted: true,
        ),
        _buildTimelineItem(
          'Arrived at Destination',
          'Package arrived at Boston facility',
          '4:30 AM',
          'June 15, 2024',
          isCompleted: true,
        ),
        _buildTimelineItem(
          'In Transit',
          'Package in transit to destination',
          '9:15 PM',
          'June 14, 2024',
          isCompleted: true,
        ),
        _buildTimelineItem(
          'Order Shipped',
          'Package picked up by courier',
          '2:30 PM',
          'June 14, 2024',
          isCompleted: true,
        ),
        _buildTimelineItem(
          'Order Confirmed',
          'Your order has been confirmed',
          '10:00 AM',
          'June 14, 2024',
          isCompleted: true,
          isFirst: true,
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    String title,
    String description,
    String time,
    String date, {
    bool isCompleted = false,
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
                    isCompleted ? Icons.check : Icons.circle,
                    color: isCompleted ? Colors.white : MEColors.textSecondary,
                    size: isCompleted ? 24 : 8,
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
            child: Container(
              margin: EdgeInsets.only(
                bottom: isLast ? 0 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? MEColors.textPrimary : MEColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: MEColors.textSecondary,
                      fontSize: 14,
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

  Widget _buildShippingDetail(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: MEColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 