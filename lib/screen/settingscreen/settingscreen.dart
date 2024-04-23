import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/models/profilescreen.dart';
import 'package:merchmoney/screen/innerscreen/onboardingscreeen.dart';
import 'package:merchmoney/screen/profilescreen/functions.dart';
import 'package:merchmoney/screen/profilescreen/introprofilescreen.dart';

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
      print("Shop Name: $shopename");
      print("Image Path: $image");
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to login screen or perform any post-logout actions
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
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _logout();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Introscreen(),
                ));
              },
              child: Text("Logout"),
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
                                child: image.isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                                radius: 60,
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
                  TextButton(
                    onPressed: () {
                      // Handle About Us button press
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Color(0xFF030655),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "About Us",
                            style: TextStyle(
                              color: Color(0xFF030655),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle Privacy & Policy button press
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.note,
                            color: Color(0xFF030655),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Privacy & Policy",
                            style: TextStyle(
                              color: Color(0xFF030655),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _confirmLogout(context); // Show confirmation dialog
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Color(0xFF030655),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Logout",
                            style: TextStyle(
                              color: Color(0xFF030655),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
