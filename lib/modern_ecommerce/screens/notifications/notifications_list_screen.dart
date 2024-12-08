import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/base_screen.dart';

class NotificationsListScreen extends StatelessWidget {
  const NotificationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Notifications',
      actions: [
        TextButton(
          onPressed: () {
            // Clear all notifications
          },
          child: const Text('Clear All'),
        ),
      ],
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: MEColors.cardBackground,
              child: const TabBar(
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Orders'),
                  Tab(text: 'Offers'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildNotificationsList('all'),
                  _buildNotificationsList('orders'),
                  _buildNotificationsList('offers'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList(String type) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildNotificationItem(type, index);
      },
    );
  }

  Widget _buildNotificationItem(String type, int index) {
    NotificationInfo info = _getNotificationInfo(type, index);

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle notification tap
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: info.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    info.icon,
                    color: info.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.title,
                        style: METextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.message,
                        style: METextStyles.bodyMedium.copyWith(
                          color: MEColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.time,
                        style: METextStyles.bodySmall.copyWith(
                          color: MEColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!info.isRead)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: MEColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NotificationInfo _getNotificationInfo(String type, int index) {
    if (type == 'orders') {
      return NotificationInfo(
        icon: Icons.local_shipping_outlined,
        color: Colors.blue,
        title: 'Order #1234 Shipped',
        message: 'Your order has been shipped and will arrive in 2-3 days.',
        time: '2 hours ago',
        isRead: index % 3 == 0,
      );
    } else if (type == 'offers') {
      return NotificationInfo(
        icon: Icons.local_offer_outlined,
        color: Colors.orange,
        title: 'Special Offer!',
        message: 'Get 50% off on all electronics this weekend!',
        time: '1 day ago',
        isRead: index % 2 == 0,
      );
    } else {
      List<NotificationInfo> notifications = [
        NotificationInfo(
          icon: Icons.local_shipping_outlined,
          color: Colors.blue,
          title: 'Order Status Update',
          message: 'Your order #1234 has been delivered.',
          time: '3 hours ago',
          isRead: false,
        ),
        NotificationInfo(
          icon: Icons.payment_outlined,
          color: Colors.green,
          title: 'Payment Successful',
          message: 'Payment of \$199.99 was successful.',
          time: '5 hours ago',
          isRead: true,
        ),
        NotificationInfo(
          icon: Icons.local_offer_outlined,
          color: Colors.orange,
          title: 'Flash Sale!',
          message: 'Don\'t miss out on our biggest sale of the year.',
          time: '1 day ago',
          isRead: true,
        ),
      ];

      return notifications[index % notifications.length];
    }
  }
}

class NotificationInfo {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final String time;
  final bool isRead;

  NotificationInfo({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
  });
} 