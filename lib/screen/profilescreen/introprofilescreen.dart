import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchmoney/helper/helperfunctions.dart';
import 'package:merchmoney/service/databaseservice.dart';

import 'package:merchmoney/widgets/textfield.dart';

class IntroprofileScreen extends StatefulWidget {
  const IntroprofileScreen({super.key});

  @override
  State<IntroprofileScreen> createState() => _IntroprofileScreenState();
}

class _IntroprofileScreenState extends State<IntroprofileScreen> {
  File? selectedImage;
  File? image;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController shopnamecontroller = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  @override
  void initState() {
    super.initState();

    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Get the current user's UID
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        // Retrieve the user document snapshot from Firestore
        DocumentSnapshot userSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        // Check if the user document exists
        if (userSnapshot.exists) {
          // Extract the 'Name' field from the document data
          String? fullName = userSnapshot['Name'];

          // Set the full name to the text controller
          if (fullName != null) {
            namecontroller.text = fullName;
          }

          // Update the UI
          setState(() {});
        } else {
          print('User data not found for UID: $uid');
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF030655),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "MERCH MONEY",
          style: GoogleFonts.ubuntu(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: const Color(0xFF030655),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage: image != null ? FileImage(image!) : null,
                      child: image == null ? const Icon(Icons.person) : null,
                    ),
                    Positioned(
                      right: 22,
                      bottom: 8,
                      child: InkWell(
                          onTap: () {
                            shomimageOption(
                              context,
                            );
                          },
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFF030655),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Full Name",
                style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormFieldWidget(
              controller: namecontroller,
              fillcolourvalue: true,
              fillColor: Colors.white,
              keyboardType: TextInputType.text,
              prefixIcon: const Icon(Icons.person_2_outlined),
              hintText: "Enter your name",
              labeltext: "username",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 25),
              child: Text(
                "Shope Name",
                style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormFieldWidget(
              controller: shopnamecontroller,
              fillcolourvalue: true,
              fillColor: Colors.white,
              keyboardType: TextInputType.text,
              prefixIcon: const Icon(Icons.shop_two_rounded),
              hintText: "Enter your Shopename",
              labeltext: "shopename",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 25),
              child: Text(
                "Phone Number",
                style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormFieldWidget(
              controller: shopnamecontroller,
              fillcolourvalue: true,
              fillColor: Colors.white,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.phone_android_outlined),
              hintText: "Enter your PhoneNumber",
              labeltext: "Phone Number",
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              child: SizedBox(
                  width: screenwidth * 0.9,
                  height: screenheight * 0.06,
                  child: ElevatedButtonnWidget(
                      customshape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      textcolor: const Color(0xFF030655),
                      backgroundcolor: Colors.white,
                      onpressed: () {},
                      buttontext: "CONFRIM")),
            ),
          ],
        ),
      ),
    );
  }

  void shomimageOption(
    BuildContext context,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        pickimageFromgallery();
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.image,
                            color: Color(0xFF030655),
                            size: 70,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        captureimagefrom();
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Color(0xFF030655),
                            size: 70,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future pickimageFromgallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(returnImage.path);
      image = File(returnImage.path);
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future captureimagefrom() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(returnImage.path);
      image = File(returnImage.path);
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
