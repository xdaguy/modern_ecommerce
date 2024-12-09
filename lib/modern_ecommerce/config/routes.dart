import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/address/add_address_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/payment/add_payment_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/profile/orders/my_orders_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/splash/splash_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/auth/login_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/auth/signup_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/main_layout.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/categories/category_detail_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/flash_sale/flash_sale_screen.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/category.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/dummy_data.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignupScreen(),
    '/main': (context) => const MainLayout(),
    '/add-address': (context) => const AddAddressScreen(),
    '/add-payment': (context) => const AddPaymentScreen(),
    '/my-orders': (context) => const MyOrdersScreen(),
    '/flash-sale': (context) => const FlashSaleScreen(),
  };

  // Handle dynamic routes with parameters
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/category') {
      final args = settings.arguments as Map<String, dynamic>?;
      final categoryName = args?['category'] as String? ?? '';
      
      // Find category from dummy data
      final category = dummyCategories.firstWhere(
        (c) => c.name.toLowerCase() == categoryName.toLowerCase(),
        orElse: () => dummyCategories.first,
      );

      return MaterialPageRoute(
        builder: (context) => CategoryDetailScreen(
          category: category,
        ),
      );
    }
    return null;
  }
} 