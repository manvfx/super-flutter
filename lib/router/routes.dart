import 'package:citizen/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:citizen/screens/home_screen.dart';
import 'package:citizen/screens/profile_screen.dart';
import 'package:citizen/screens/search_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => SearchScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
  ],
);
