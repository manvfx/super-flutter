import 'package:citizen/screens/dashboard/home_screen.dart';
import 'package:citizen/screens/dashboard/profile_screen.dart';
import 'package:citizen/screens/dashboard/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainWrapper extends StatefulWidget {
  final String accessToken;

  const MainWrapper({super.key, required this.accessToken});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _bottomIndex = 0;

  late List<Widget> screensList;

  String? username;

  @override
  void initState() {
    super.initState();
    screensList = [
      HomeScreen(accessToken: widget.accessToken),
      SearchScreen(),
      ProfileScreen(),
    ];
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? widget.accessToken;

    final response = await http.get(
      Uri.parse('https://api.nexhouse.ir/api/v1/filefinder/profile'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final profile = jsonDecode(response.body);
      setState(() {
        username = profile['username'];
      });
    } else {
      // Handle profile fetch error
      print('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _bottomIndex,
        onTap: (value) {
          setState(() {
            _bottomIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'خانه',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'جستجو',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            activeIcon: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: _bottomIndex,
        children: screensList,
      ),
    );
  }
}
