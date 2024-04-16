import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/helper/helperfunctions.dart';
import 'package:merchmoney/screen/homescreen/bottomnavigation.dart';

import 'package:merchmoney/screen/innerscreen/signupscreen.dart';
import 'package:merchmoney/service/authservice.dart';
import 'package:merchmoney/service/databaseservice.dart';
import 'package:merchmoney/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String username = "";
  bool isloading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF030655),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                      "assets/images/Picsart_23-12-13_12-36-51-103.png"),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Welcome Back !",
                            style: GoogleFonts.poppins(
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, top: 10),
                          child: Text(
                            "Sign Into Your Account",
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: screenHeight * .02),
                            TextFormFieldWidget(
                              keyboardType: TextInputType.emailAddress,
                              obscureValue: false,
                              prefixIcon: const Icon(Icons.email_outlined),
                              labeltext: "E-mail",
                              fillcolourvalue: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your E-mail.',
                              controller: emailController,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Please Enter valid Email";
                              },
                            ),
                            TextFormFieldWidget(
                              keyboardType: TextInputType.number,
                              obscureValue: true,
                              prefixIcon:
                                  const Icon(Icons.fingerprint_outlined),
                              labeltext: "Password",
                              fillcolourvalue: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your Password.',
                              controller: passwordController,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              validator: (val) {
                                if (val!.length < 6) {
                                  return "Password Must be at least 6 characters ";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: GoogleFonts.ubuntu(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButtonWidget(
                                    onpressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen(),
                                      ));
                                    },
                                    textbutton: "SignUp",
                                    textcolor: const Color.fromARGB(
                                        255, 255, 255, 255)),
                              ],
                            ),
                            SizedBox(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.05,
                              child: ElevatedButtonnWidget(
                                onpressed: () {
                                  login();
                                },
                                buttontext: "LOGIN",
                                customshape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                backgroundcolor: Colors.white,
                                textcolor: const Color(0xFF030655),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          // ignore: unused_local_variable
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserdata(email);
          //saving the values in sharedpreferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSf(email);
          await HelperFunctions.saveUserNameSf(username);
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Navbar(
              email: emailController.text,
            ),
          ));
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            isloading = false;
          });
        }
      });
    }
  }
}
