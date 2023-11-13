import 'package:flutter/material.dart';
import 'dart:async'; // Import for the 'Future' class

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 4 seconds before navigating to the next page
    Timer(Duration(seconds: 4), () {
      // Navigate to the next page (replace '/WelcomeScreen' with your desired route)
      Navigator.of(context).pushReplacementNamed('/WelcomeScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black, // Set the background color to black
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            Image.asset(
              'assets/images/Grocery_bag.png',
              height: 300.0,
              width: 300.0,
            ),
          ],
        ),
      ),
    );
  }
}
