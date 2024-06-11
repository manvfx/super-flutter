import 'package:citizen/wrapper/main_wrapper.dart';
import 'package:go_router/go_router.dart';
import 'package:citizen/screens/splash/splash_screen.dart';
import 'package:citizen/screens/auth/login_screen.dart';
import 'package:citizen/screens/auth/verify-screen.dart';
import 'package:citizen/screens/error/error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<Map<String, dynamic>> _isAuthenticated() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  return {
    'isAuthenticated': accessToken != null,
    'accessToken': accessToken,
  };
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
      builder: (context, state) => FutureBuilder<Map<String, dynamic>>(
        future: _isAuthenticated(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!['isAuthenticated'] == true) {
            final accessToken = snapshot.data!['accessToken'];
            return MainWrapper(accessToken: accessToken);
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
    GoRoute(
      path: '/verify',
      name: 'verify',
      builder: (context, state) {
        final mobile = state.extra as String;
        return VerifyScreen(mobile: mobile);
      },
    ),
  ],
);
