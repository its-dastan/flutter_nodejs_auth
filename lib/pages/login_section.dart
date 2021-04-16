import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_nodejs_auth/pages/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSection extends StatefulWidget {
  static const String id = "LoginSection";
  @override
  _LoginSectionState createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  static const String id = "LoginSection";
  var email;
  var password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
        ),
        child: SafeArea(
          child: ListView(
            restorationId: 'text_field_demo_list_view',
            padding: const EdgeInsets.all(16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoTextField(
                  onChanged: (value) => {email = value},
                  restorationId: 'email_address_text_field',
                  placeholder: "Email",
                  keyboardType: TextInputType.emailAddress,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  autocorrect: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoTextField(
                  onChanged: (value) => {password = value},
                  restorationId: 'login_password_text_field',
                  placeholder: 'password',
                  clearButtonMode: OverlayVisibilityMode.editing,
                  obscureText: true,
                  autocorrect: false,
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  await login(email, password);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String token = (prefs.getString('token'));

                  if (token != null) {
                    Navigator.pushNamed(context, LandingScreen.id);
                  }
                },
                icon: Icon(Icons.save),
                label: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

login(email, password) async {
  var url = Uri.parse("http://192.168.43.101:5000/login");
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  print(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var parse = jsonDecode(response.body);
  await prefs.setString('token', parse['token']);
}
