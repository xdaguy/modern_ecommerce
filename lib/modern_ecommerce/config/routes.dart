import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/address/add_address_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/payment/add_payment_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/profile/orders/my_orders_screen.dart';

class AppRoutes {
  static final routes = {
    '/add-address': (context) => const AddAddressScreen(),
    '/add-payment': (context) => const AddPaymentScreen(),
    '/my-orders': (context) => const MyOrdersScreen(),
  };
} 