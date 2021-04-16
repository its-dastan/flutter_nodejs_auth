import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTextFieldDemo(),
    );
  }
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class CupertinoTextFieldDemo extends StatefulWidget {
  @override
  _CupertinoTextFieldDemoState createState() => _CupertinoTextFieldDemoState();
}

class _CupertinoTextFieldDemoState extends State<CupertinoTextFieldDemo> {
  var email;

  var password;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
              onPressed: () {
                print(email);
                print(password);
                signup(email, password);
              },
              icon: Icon(Icons.save),
              label: Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}

signup(email, password) async {
  print("in signup function");
  var url = Uri.parse("http://192.168.43.101:5000/signup");
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

  if (response.statusCode == 201) {
  } else {
    throw Exception('Failed to create album.');
  }
}
