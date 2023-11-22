import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const route = '/';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white, // Light blue at the top right
              Colors.lightBlue.shade200, // Old blue in the middle
              Colors.white,
            ],
            // Adjust the stops if needed to control the flow of the gradient
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all()
              ),
            )
          ],
        ),
      ),
    );
  }
}
