import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const route = '/';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.lightBlue, // Light blue at the top right
        Colors.blue,      // Old blue in the middle
        Colors.blue,      // Old blue again at the bottom left
      ],
      // Adjust the stops if needed to control the flow of the gradient
      stops: [0.0, 0.5, 1.0],
    ),
  ),
),
    );
  }
}
