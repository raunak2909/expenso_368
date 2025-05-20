import 'dart:async';

import 'package:expense_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.WELCOME_PAGE_ROUTE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash image.png',
            fit: BoxFit.cover,
            height: 450,
          ),
          Text(
            "Expense Tracker",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 27,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
