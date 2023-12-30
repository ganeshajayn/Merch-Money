import 'package:flutter/material.dart';
import 'package:merchmoney/screen/innerscreen/onboardingscreeen.dart';
import 'package:merchmoney/service/authservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              authService.signOut();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Introscreen(),
              ));
            },
            child: Text("LOGOUT")),
      ),
    );
  }
}
