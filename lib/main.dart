import 'package:flutter/material.dart';
import 'package:qr_redeem/view/Homescreen.dart';
import 'package:qr_redeem/view/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/homepage': (context) => const HomeScreen(),
      },
    );
  }
}
