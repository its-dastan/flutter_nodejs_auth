import 'package:flutter/material.dart';
import 'pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupSection(),
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        LoginSection.id: (context) => LoginSection(),
      },
    );
  }
}
