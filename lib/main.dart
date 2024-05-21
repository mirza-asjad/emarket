import 'package:emarket/db/local_db.dart';
import 'package:emarket/views/emarketUI/home/components/badges_counter.dart';
import 'package:emarket/views/emarketUI/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
// Import your DatabaseHelper class
import 'package:emarket/res/localization/languages.dart';
import 'package:emarket/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that the Flutter binding is initialized

  // Initialize the database
  await DatabaseHelper.instance.initDatabase();
  Get.put<CartController>(CartController());
  Stripe.publishableKey =
      'pk_test_51PAV0TL5n3aVrGOjjTe4nluANZk9OJGpvQtd45XIerRErUXcw7EFra6jl4AXiJ3MuLuVKhhTFJGkqsxloBbSRax000WKn7f8C0';

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: 'e Market',
      home: const HomeScreen(),
      theme: AppTheme.lightTheme(context),
    );
  }
}
