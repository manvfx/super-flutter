import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://217.60.251.12:8181/api/v4/user/profile'),
        headers: {
          'Authorization': 'Bearer $token',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('پروفایل من')),
      body: Center(
        child: username != null
            ? Text('Username: $username')
            : CircularProgressIndicator(),
      ),
    );
  }
}
