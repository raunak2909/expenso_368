import 'package:expense_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/expense_app_images copy.tiff'),
            SizedBox(height: 20),
            Text(
              "Easy way to monitor \n       your expense",
              style: TextStyle(
                fontSize: 31,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14),
            Text(
              "Safe your future by managing your \n               expense right now",
              style: TextStyle(
                color: Color(0XFF8D8E9B),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFFE88DBE),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.HOME_PAGE_ROUTE);
        },
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}
