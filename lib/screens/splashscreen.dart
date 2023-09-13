import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_application/screens/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate a splash screen.
    Timer(const Duration(seconds: 2), () {
      // Navigate to the main screen or another screen after the splash screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Image.asset(
              'assets/splash_pic.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text("Top Headlines",
              style: GoogleFonts.anton(letterSpacing: 5, color: Colors.grey)),
          SizedBox(
            height: 30,
          ),
          SpinKitChasingDots(
            color: Color.fromARGB(255, 190, 44, 22),
            size: 100,
          )
        ],
      ),
    ));
  }
}
