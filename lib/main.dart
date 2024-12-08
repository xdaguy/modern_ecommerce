import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_ecommerce/modern_ecommerce/screens/main_layout.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Status bar color (top)
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      
      // Navigation bar color (bottom)
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Ecommerce UI Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MEColors.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: MEColors.background,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainLayout(),
    );
  }
}
