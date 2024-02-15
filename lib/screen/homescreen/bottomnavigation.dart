// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:merchmoney/screen/homescreen/categorypage.dart';
import 'package:merchmoney/screen/homescreen/graphscreen.dart';
import 'package:merchmoney/screen/homescreen/homescreen.dart';
import 'package:merchmoney/screen/homescreen/settingscren.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedindex = 0;
  void navigationbar(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      const HomeScreen(),
      CategoryScreen(),
      const Graphscreen(),
      const Settingscreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedindex],
      bottomNavigationBar: GNav(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          activeColor: const Color(0xFF030655),
          backgroundColor: Colors.white,
          gap: 10,
          iconSize: 18,
          textSize: 12,
          selectedIndex: selectedindex,
          onTabChange: (index) {
            navigationbar(index);
          },
          tabs: [
            const GButton(
              icon: Icons.home,
              text: "Home",
            ),
            const GButton(
              icon: Icons.favorite_border,
              text: "Category",
            ),
            const GButton(
              icon: Icons.search,
              text: "search",
            ),
            const GButton(
              icon: Icons.settings,
              text: "Settings",
            ),
          ]),
    );
  }
}
