import 'package:flutter/material.dart';
import 'package:flutter_nodejs_auth/pages/login_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatelessWidget {
  static const String id = "LandingScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Welcome to the landing Screen"),
          ),
          TextButton.icon(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              Navigator.pushNamed(context, LoginSection.id);
            },
            icon: Icon(Icons.logout),
            label: Text("Logout"),
          )
        ],
      ),
    );
  }
}
