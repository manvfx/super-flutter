import 'package:citizen/screens/dashboard/home_screen.dart';
import 'package:citizen/screens/dashboard/profile_screen.dart';
import 'package:citizen/screens/dashboard/search_screen.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainWrapper> {
  int _bottomIndex = 0;
  List<Widget> screensList = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen()
  ];
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
            label: 'پروفایل من',
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