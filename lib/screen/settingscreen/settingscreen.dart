import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/screen/profilescreen/introprofilescreen.dart';
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
      body: SafeArea(
          child: Container(
        color: Colors.white38,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.sizeOf(context).height * 0.16,
              width: 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.settings),
                      ),
                      Text(
                        "Settings",
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF030655)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.746,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                  color: Color(0xFF030655),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 20),
                    child: InkWell(
                        splashColor: Colors.white,
                        splashFactory: InkSplash.splashFactory,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const IntroprofileScreen(),
                          ));
                        },
                        child: const Textwidget(
                            title: "Profile", textColor: Colors.white)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 20),
                    child:
                        Textwidget(title: "About Us", textColor: Colors.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 20),
                    child: Textwidget(
                        title: "Privacy&Policy", textColor: Colors.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 20),
                    child:
                        Textwidget(title: "Rate Us", textColor: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
