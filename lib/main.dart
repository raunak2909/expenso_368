import 'package:expense_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense App",
      initialRoute: AppRoutes.SPLASH_PAGE_ROUTE,
      routes: AppRoutes.mRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
