import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:merchmoney/helper/helperfunctions.dart';
import 'package:merchmoney/screen/homescreen/bottomnavigation.dart';

import 'package:merchmoney/screen/innerscreen/onboardingscreeen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInstatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        backgroundColor: Colors.white,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Lottie.asset(
                  "assets/images/splash.json",
                ),
                Text(
                  "MERCH MONEY",
                  style: GoogleFonts.ubuntu(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF030655)),
                )
              ],
            ),
          ],
        ),
        splashIconSize: 500,
        duration: 5000,
        splashTransition: SplashTransition.sizeTransition,
        nextScreen: _isSignedIn ? const Navbar() : const Introscreen());
  }
}
