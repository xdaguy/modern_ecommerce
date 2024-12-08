import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/cart_provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/address/add_address_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/payment/add_payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  final _addressFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  // Selected values
  String? _selectedAddress;
  String? _selectedPayment;
  String _selectedShipping = 'standard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MEColors.background,
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: MEColors.cardBackground,
            child: Row(
              children: [
                _buildStepIndicator('Delivery', 0),
                _buildStepDivider(),
                _buildStepIndicator('Payment', 1),
                _buildStepDivider(),
                _buildStepIndicator('Review', 2),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  [
                    _buildDeliveryStep(),
                    _buildPaymentStep(),
                    _buildReviewStep(),
                  ][_currentStep],
                ],
              ),
            ),
          ),
          
          // Bottom Bar
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(String label, int step) {
    final isActive = _currentStep >= step;
    final isCompleted = _currentStep > step;

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? MEColors.primary : MEColors.border,
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Center(
                    child: Text(
                      '${step + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.white : MEColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isActive ? MEColors.textPrimary : MEColors.textSecondary,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDivider() {
    return Container(
      width: 40,
      height: 1,
      color: MEColors.border,
    );
  }

  Widget _buildDeliveryStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shipping Address Section
          const Text('Shipping Address', style: METextStyles.h3),
          const SizedBox(height: 16),
          _buildAddressSelection(),
          const SizedBox(height: 24),
          
          // Shipping Method Section
          const Text('Shipping Method', style: METextStyles.h3),
          const SizedBox(height: 16),
          _buildShippingMethodSelection(),
        ],
      ),
    );
  }

  Widget _buildAddressSelection() {
    return Column(
      children: [
        // Existing Addresses
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: MEColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              RadioListTile(
                value: 'home',
                groupValue: _selectedAddress,
                onChanged: (value) {
                  setState(() => _selectedAddress = value as String);
                },
                title: const Text('Home'),
                subtitle: const Text('123 Main Street, New York, NY 10001'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              const Divider(height: 1),
              RadioListTile(
                value: 'office',
                groupValue: _selectedAddress,
                onChanged: (value) {
                  setState(() => _selectedAddress = value as String);
                },
                title: const Text('Office'),
                subtitle: const Text('456 Business Ave, New York, NY 10002'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddAddressScreen(),
              ),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add New Address'),
        ),
      ],
    );
  }

  Widget _buildShippingMethodSelection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MEColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          RadioListTile<String>(
            value: 'standard',
            groupValue: _selectedShipping,
            onChanged: (value) {
              setState(() => _selectedShipping = value!);
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Standard Delivery'),
                      Text(
                        '3-5 business days',
                        style: TextStyle(
                          color: MEColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('\$10.00'),
              ],
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          const Divider(height: 1),
          RadioListTile<String>(
            value: 'express',
            groupValue: _selectedShipping,
            onChanged: (value) {
              setState(() => _selectedShipping = value!);
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Express Delivery'),
                      Text(
                        '1-2 business days',
                        style: TextStyle(
                          color: MEColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('\$20.00'),
              ],
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payment Method', style: METextStyles.h3),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: MEColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  value: 'card1',
                  groupValue: _selectedPayment,
                  onChanged: (value) {
                    setState(() => _selectedPayment = value!);
                  },
                  title: Row(
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Visa'),
                          Text(
                            '•••• 4242',
                            style: TextStyle(
                              color: MEColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: const Text('Expires 12/24'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                const Divider(height: 1),
                RadioListTile<String>(
                  value: 'card2',
                  groupValue: _selectedPayment,
                  onChanged: (value) {
                    setState(() => _selectedPayment = value!);
                  },
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.credit_card,
                          color: Colors.orange,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mastercard'),
                          Text(
                            '•••• 8888',
                            style: TextStyle(
                              color: MEColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: const Text('Expires 06/25'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPaymentScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add New Payment Method'),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    final cart = context.watch<CartProvider>();
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Summary
          const Text('Order Summary', style: METextStyles.h3),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MEColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MEColors.border),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal'),
                    Text('\$${cart.subtotal.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Shipping'),
                    Text('\$${cart.shipping.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tax'),
                    Text('\$${cart.tax.toStringAsFixed(2)}'),
                  ],
                ),
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: METextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${cart.total.toStringAsFixed(2)}',
                      style: METextStyles.h3.copyWith(
                        color: MEColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Delivery Details
          const Text('Delivery Details', style: METextStyles.h3),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MEColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MEColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shipping Address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('John Doe\n123 Main Street\nNew York, NY 10001'),
                const Divider(height: 16),
                const Text(
                  'Shipping Method',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Standard Delivery (3-5 business days)'),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Payment Details
          const Text('Payment Details', style: METextStyles.h3),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MEColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MEColors.border),
            ),
            child: const Row(
              children: [
                Icon(Icons.credit_card),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visa ending in 4242',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Expires 12/24'),
                  ],
                ),
              ],
            ),
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
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep--;
                    });
                  },
                  child: const Text('Back'),
                ),
              ),
            if (_currentStep > 0)
              const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentStep < 2) {
                    setState(() {
                      _currentStep++;
                    });
                  } else {
                    _placeOrder();
                  }
                },
                child: Text(_currentStep < 2 ? 'Continue' : 'Place Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder() {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Dismiss loading dialog
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Order Placed Successfully'),
          content: const Text('Thank you for your order! You will receive a confirmation email shortly.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Dismiss dialog
                Navigator.pop(context); // Go back to cart
                // Clear cart
                context.read<CartProvider>().clear();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
} 