import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/base_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final Map<String, bool> _notificationSettings = {
    'Order Updates': true,
    'Promotions & Offers': true,
    'Price Drops': false,
    'New Arrivals': true,
    'Payment Updates': true,
    'Delivery Status': true,
    'Account Activity': false,
    'Newsletter': false,
  };

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Notifications',
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Notification Preferences',
              style: METextStyles.h3,
            ),
          ),
          Container(
            color: MEColors.cardBackground,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _notificationSettings.length,
              itemBuilder: (context, index) {
                final key = _notificationSettings.keys.elementAt(index);
                final value = _notificationSettings[key]!;
                return Column(
                  children: [
                    SwitchListTile(
                      value: value,
                      onChanged: (newValue) {
                        setState(() {
                          _notificationSettings[key] = newValue;
                        });
                      },
                      title: Text(key),
                      subtitle: Text(_getSubtitle(key)),
                    ),
                    if (index < _notificationSettings.length - 1)
                      const Divider(height: 1),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Recent Notifications',
              style: METextStyles.h3,
            ),
          ),
          _buildNotificationsList(),
        ],
      ),
    );
  }

  String _getSubtitle(String key) {
    switch (key) {
      case 'Order Updates':
        return 'Get notified about your order status';
      case 'Promotions & Offers':
        return 'Receive special offers and promotions';
      case 'Price Drops':
        return 'Get alerts when items in your wishlist drop in price';
      case 'New Arrivals':
        return 'Be the first to know about new products';
      case 'Payment Updates':
        return 'Receive payment confirmations and updates';
      case 'Delivery Status':
        return 'Track your package delivery status';
      case 'Account Activity':
        return 'Get alerts about account security and activity';
      case 'Newsletter':
        return 'Receive our weekly newsletter';
      default:
        return '';
    }
  }

  Widget _buildNotificationsList() {
    return Container(
      color: MEColors.cardBackground,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MEColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getNotificationIcon(index),
                color: MEColors.primary,
                size: 24,
              ),
            ),
            title: Text(
              _getNotificationTitle(index),
              style: METextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(_getNotificationMessage(index)),
                const SizedBox(height: 4),
                Text(
                  '2 hours ago',
                  style: METextStyles.bodySmall.copyWith(
                    color: MEColors.textSecondary,
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          );
        },
      ),
    );
  }

  IconData _getNotificationIcon(int index) {
    switch (index % 5) {
      case 0:
        return Icons.local_shipping_outlined;
      case 1:
        return Icons.payment;
      case 2:
        return Icons.local_offer_outlined;
      case 3:
        return Icons.shopping_bag_outlined;
      case 4:
        return Icons.notifications_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _getNotificationTitle(int index) {
    switch (index % 5) {
      case 0:
        return 'Order Shipped';
      case 1:
        return 'Payment Successful';
      case 2:
        return 'Special Offer';
      case 3:
        return 'Order Confirmed';
      case 4:
        return 'Price Drop Alert';
      default:
        return 'Notification';
    }
  }

  String _getNotificationMessage(int index) {
    switch (index % 5) {
      case 0:
        return 'Your order #1234 has been shipped and will arrive in 2-3 days.';
      case 1:
        return 'Payment of \$199.99 for order #1234 was successful.';
      case 2:
        return 'Get 50% off on all electronics this weekend!';
      case 3:
        return 'Your order #1234 has been confirmed and is being processed.';
      case 4:
        return 'A product in your wishlist is now on sale!';
      default:
        return 'You have a new notification.';
    }
  }
} 