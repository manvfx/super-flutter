import 'package:citizen/wrapper/main_wrapper.dart';
import 'package:go_router/go_router.dart';
import 'package:citizen/screens/splash/splash_screen.dart';
import 'package:citizen/screens/auth/login_screen.dart';
import 'package:citizen/screens/error/error_screen.dart';

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
      builder: (context, state) => MainWrapper(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
