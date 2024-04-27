import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/models/profilescreen.dart';
import 'package:merchmoney/screen/innerscreen/onboardingscreeen.dart';
import 'package:merchmoney/screen/profilescreen/functions.dart';
import 'package:merchmoney/screen/profilescreen/introprofilescreen.dart';
import 'package:merchmoney/widgets/textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({Key? key}) : super(key: key);

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  String userName = "";
  String image = "";
  String shopename = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchProfileData();
  }

  Future<void> fetchUserData() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (userSnapshot.exists) {
        setState(() {
          userName = userSnapshot['Name'];
        });
      }
    }
  }

  Future<void> fetchProfileData() async {
    final Profilemodel? data = await getprofile();

    if (data != null) {
      setState(() {
        image = data.imagepath ?? "demo";
        shopename = data.shopname ?? "demoo";
      });
      // print("Shop Name: $shopename");
      print("Image Path: $image");
    }
  }

  Future<void> _refreshScreen() async {
    // Reload user data and profile data
    await fetchUserData();
    await fetchProfileData();
    // Trigger a screen refresh
    setState(() {});
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Error logging out: $e");
      // Handle error, if any
    }
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _logout();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Introscreen(),
                ));
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF030655),
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "Profile",
            style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: height * 0.26,
                  color: const Color(0xFF030655),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 35,
                    left: 10,
                    right: 10,
                    bottom: 30,
                  ),
                  child: Container(
                    height: height * 0.3,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 4,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const IntroprofileScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit_note_rounded),
                            color: Colors.black,
                          ),
                        ),
                        Positioned(
                            top: 10,
                            left: 20,
                            child: IconButton(
                                onPressed: () {
                                  _refreshScreen();
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                ))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CircleAvatar(
                                backgroundImage: image.isNotEmpty
                                    ? FileImage(File(image))
                                    : null,
                                radius: 60,
                                child: image.isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              userName,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              shopename,
                              style: GoogleFonts.roboto(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white12,
              height: height * 0.53,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetListTile(
                      tileColor: const Color(0xFF030655),
                      leaddingtileIcon: Icons.person,
                      titleText: "About Us ",
                      onTapAction: () {
                        showAboutDialog(
                            context: context,
                            applicationName: 'MerchMoney',
                            applicationVersion: "version 1");
                      }),
                  WidgetListTile(
                      tileColor: const Color(0xFF030655),
                      leaddingtileIcon: Icons.privacy_tip_sharp,
                      titleText: "Privacy&policy",
                      onTapAction: () {
                        launchUrl(Uri.parse(
                            "https://www.freeprivacypolicy.com/live/34d0e172-7976-407c-878e-81ba571d4587"));
                      }),
                  WidgetListTile(
                      tileColor: const Color(0xFF030655),
                      leaddingtileIcon: Icons.person,
                      titleText: "Terms & conditions ",
                      onTapAction: () {
                        launchUrl(Uri.parse(
                            "https://www.app-privacy-policy.com/live.php?token=ZP09mKQoPNw7Zsec4PhdanKrZuIl1HwJ"));
                      }),
                  WidgetListTile(
                      tileColor: const Color(0xFF030655),
                      leaddingtileIcon: Icons.logout_outlined,
                      titleText: "Logout",
                      onTapAction: () {
                        _confirmLogout(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white12,
    );
  }
}
