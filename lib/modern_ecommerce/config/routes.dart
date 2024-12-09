import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/address/add_address_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/payment/add_payment_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/profile/orders/my_orders_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/splash/splash_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/auth/login_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/auth/signup_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/main_layout.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignupScreen(),
    '/main': (context) => const MainLayout(),
    '/add-address': (context) => const AddAddressScreen(),
    '/add-payment': (context) => const AddPaymentScreen(),
    '/my-orders': (context) => const MyOrdersScreen(),
  };
} 