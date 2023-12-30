import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/screen/innerscreen/loginscreen.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({super.key});

  @override
  State<Introscreen> createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030655),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              height: 350.0,
              width: 400.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CarouselSlider(
                      items: [
                        SizedBox(
                          height: 400.0,
                          width: 400.0,
                          child: Center(
                            child: Image.asset(
                              "assets/images/business-chart_869423-670.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 400.0,
                          width: 400.0,
                          child: Center(
                            child: Image.asset(
                              "assets/images/healthy-grocery-shopping_488220-32484.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 400.0,
                          width: 400.0,
                          child: Center(
                            child: Image.asset(
                              "assets/images/businessman-holding-something-white-background.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 200,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 500),
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentindex = index;
                          });
                        },
                      ),
                    ),
                    // Dot indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3, // Number of items in your carousel
                        (index) => Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 2.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentindex == index
                                ? Colors.blue
                                : Colors.grey.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Keep Your Products Safe",
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    "Empower your business journey with our app,where every sale tells a story",
                    style:
                        GoogleFonts.ubuntu(fontSize: 24, color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 240,
            ),
            SizedBox(
              height: 50,
              width: 360,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
                  },
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.ubuntu(
                        color: const Color(0xFF030655),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
