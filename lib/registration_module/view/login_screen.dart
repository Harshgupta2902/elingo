import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Hello There 👋",
            style:
                Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
