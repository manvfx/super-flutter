import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String accessToken;

  HomeScreen({required this.accessToken});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userProfile;

  Future<void> _fetchProfile() async {
    final response = await http.get(
      Uri.parse('https://api.nexhouse.ir/api/v1/filefinder/profile'),
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userProfile = jsonDecode(response.body);
      });
    } else {
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: userProfile == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userProfile!['firstName']} ${userProfile!['lastName']}'),
            Text('Mobile: ${userProfile!['mobile']}'),
            Text('Level: ${userProfile!['level']}'),
            Text('Score: ${userProfile!['score']}'),
          ],
        ),
      ),
    );
  }
}
