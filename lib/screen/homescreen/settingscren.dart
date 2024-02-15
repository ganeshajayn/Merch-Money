import 'package:flutter/material.dart';
import 'package:merchmoney/service/authservice.dart';
import 'package:merchmoney/widgets/textfield.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButtonnWidget(
          onpressed: () {
            AuthService().signOut();
          },
          buttontext: "logout",
        ),
      ),
    );
  }
}
