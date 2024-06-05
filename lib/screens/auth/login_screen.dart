import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ورود'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
          child: const Text('ورود به برنامه'),
        ),
      ),
    );
  }
}