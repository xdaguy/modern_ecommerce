import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_ecommerce/modern_ecommerce/app.dart';

/// Main entry point for the FlutterFusion application.
/// Configures system UI appearance and initializes the app.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  runApp(const ModernEcommerceApp());
}
