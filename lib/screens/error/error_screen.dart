import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.blue,
              ),
              SizedBox(height: 16),
              Text(
                'Error: Page not found',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ));
  }
}