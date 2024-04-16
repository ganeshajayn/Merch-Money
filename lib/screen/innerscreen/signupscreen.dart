import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/helper/helperfunctions.dart';
import 'package:merchmoney/screen/homescreen/bottomnavigation.dart';
import 'package:merchmoney/screen/homescreen/homescreen.dart';

import 'package:merchmoney/screen/profilescreen/introprofilescreen.dart';
import 'package:merchmoney/screen/innerscreen/loginscreen.dart';

import 'package:merchmoney/service/authservice.dart';
import 'package:merchmoney/widgets/textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> signupformkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  String email = "";
  String fullname = "";
  String password = "";
  String confirmPassword = "";
  bool isloading = false;
  AuthService authserrvice = AuthService();
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                      "assets/images/WhatsApp Image 2023-12-16 at 17.21.31_2d8fcd2f.jpg"),
                  Form(
                    key: signupformkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Create Account",
                            style: GoogleFonts.poppins(
                                fontSize: 35, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "Have a New One !",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        TextFormFieldWidget(
                          controller: namecontroller,
                          fillColor: Colors.white,
                          fillcolourvalue: true,
                          keyboardType: TextInputType.name,
                          obscureValue: false,
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Enter your name",
                          labeltext: "Name",
                          onChanged: (val) {
                            setState(() {
                              fullname = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name cannot be empty";
                            }
                          },
                        ),
                        TextFormFieldWidget(
                          controller: emailcontroller,
                          fillColor: Colors.white,
                          fillcolourvalue: true,
                          keyboardType: TextInputType.emailAddress,
                          obscureValue: false,
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: "Enter your E-mail",
                          labeltext: "E-mail",
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
                          controller: passwordcontroller,
                          fillColor: Colors.white,
                          fillcolourvalue: true,
                          keyboardType: TextInputType.emailAddress,
                          obscureValue: true,
                          prefixIcon: const Icon(Icons.security),
                          hintText: "Enter your Password",
                          labeltext: "New Password",
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be atleast 6 characters";
                            } else {
                              return null;
                            }
                          },
                        ),
                        TextFormFieldWidget(
                          controller: confirmpasswordcontroller,
                          fillColor: Colors.white,
                          fillcolourvalue: true,
                          keyboardType: TextInputType.emailAddress,
                          obscureValue: true,
                          prefixIcon: const Icon(Icons.security),
                          hintText: "Enter your Password",
                          labeltext: "Confirm Password",
                          onChanged: (val) {
                            setState(() {
                              confirmPassword = val;
                            });
                          },
                          validator: (val) {
                            if (val != password) {
                              return "Incorrect Passwod";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            child: SizedBox(
                          height: screenheight * 0.06,
                          width: screenwidth * 0.9,
                          child: ElevatedButtonnWidget(
                              onpressed: () {
                                register();
                              },
                              customshape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              textcolor: const Color(0xFF030655),
                              backgroundcolor: Colors.white,
                              buttontext: "Save"),
                        ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      TextButtonWidget(
                        onpressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                        },
                        textbutton: "Sign In",
                        textcolor: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  register() async {
    if (signupformkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      await authserrvice
          .registerUserWithEmailandPassword(
        email,
        password,
        fullname,
      )
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSf(email);
          await HelperFunctions.saveUserNameSf(fullname);
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Navbar(
              email: emailcontroller.text,
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
