import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import home screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 70, 70, 70),
      body: Center(
        child: Image.asset('assets/yamaha_logo.png', width: 150), // Ensure image is in assets
      ),
    );
  }
}
