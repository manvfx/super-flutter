import 'package:citizen/wrapper/main_wrapper.dart';
import 'package:go_router/go_router.dart';
import 'package:citizen/screens/splash/splash_screen.dart';
import 'package:citizen/screens/auth/login_screen.dart';
import 'package:citizen/screens/error/error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<bool> _isAuthenticated() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwtToken');
  return token != null;
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => FutureBuilder<bool>(
        future: _isAuthenticated(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data == true) {
            return MainWrapper();
          } else {
            return LoginScreen();
          }
        },
      ),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
