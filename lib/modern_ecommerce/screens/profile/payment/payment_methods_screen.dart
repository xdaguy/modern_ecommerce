import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/base_screen.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Payment Methods',
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPaymentCard(
            isDefault: true,
            cardType: 'Visa',
            lastFourDigits: '4242',
            expiryDate: '12/24',
            cardHolderName: 'John Doe',
          ),
          _buildPaymentCard(
            isDefault: false,
            cardType: 'Mastercard',
            lastFourDigits: '8888',
            expiryDate: '06/25',
            cardHolderName: 'John Doe',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard({
    required bool isDefault,
    required String cardType,
    required String lastFourDigits,
    required String expiryDate,
    required String cardHolderName,
  }) {
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
            leading: Icon(
              cardType == 'Visa' ? Icons.credit_card : Icons.credit_card,
              color: MEColors.primary,
              size: 32,
            ),
            title: Row(
              children: [
                Text(
                  '$cardType •••• $lastFourDigits',
                  style: METextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isDefault) ...[
                  const SizedBox(width: 8),
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
                      'Default',
                      style: METextStyles.bodySmall.copyWith(
                        color: MEColors.primary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text('Expires $expiryDate'),
                Text(cardHolderName),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (!isDefault)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Set as Default'),
                    ),
                  ),
                if (!isDefault) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MEColors.error,
                    ),
                    child: const Text('Remove'),
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