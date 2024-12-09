import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/cart_provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/navigation_provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/wishlist_provider.dart';

/// Provider configuration for state management.
/// Sets up all required providers for the application.
class AppProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider<NavigationProvider>(
      create: (_) => NavigationProvider(),
    ),
    ChangeNotifierProvider<CartProvider>(
      create: (_) => CartProvider(),
    ),
    ChangeNotifierProvider<WishlistProvider>(
      create: (_) => WishlistProvider(),
    ),
  ];
} 