import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modern_ecommerce/modern_ecommerce/config/theme.dart';
import 'package:modern_ecommerce/modern_ecommerce/config/routes.dart';
import 'package:modern_ecommerce/modern_ecommerce/providers/providers.dart';

/// Root widget of the FlutterFusion Modern Ecommerce application.
/// Sets up providers, theme, and routing configuration.
class ModernEcommerceApp extends StatelessWidget {
  const ModernEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: MaterialApp(
        title: 'Modern Ecommerce UI Kit',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
} 