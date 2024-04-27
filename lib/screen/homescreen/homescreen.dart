import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/screen/homescreen/outofstock.dart';

import 'package:merchmoney/widgets/pichart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:merchmoney/helper/helperfunctions.dart';
import 'package:merchmoney/screen/categoryscreen/searchresults.dart';
import 'package:merchmoney/screen/destinationfolder/functions.dart';
import 'package:merchmoney/widgets/totalpricecontainer.dart';

late ValueNotifier<bool> hasNotificationsNotifier;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";

  @override
  void initState() {
    super.initState();
    hasNotificationsNotifier = ValueNotifier<bool>(false);
    gettingUserData();
  }

  @override
  void dispose() {
    hasNotificationsNotifier.dispose();
    super.dispose();
  }

  void gettingUserData() async {
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        username = val!;
      });
    });
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDataStream = StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          String? username = snapshot.data!["Name"];
          if (username != null) {
            return Padding(
              padding: const EdgeInsets.only(top: 60, left: 20),
              child: Text(
                "${getGreeting()} $username,",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            );
          }
        }
        return Container();
      },
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "MerchMoney",
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF030655),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SearchhedResults(),
              ),
            );
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notification_important_outlined,
                    color: hasNotificationsNotifier.value
                        ? Colors.red
                        : Colors.white,
                  ),
                  onPressed: () {
                    checkLowStockItems(context);
                  },
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: hasNotificationsNotifier,
                  builder: (context, hasNotifications, _) {
                    return hasNotifications
                        ? const Positioned(
                            right: 6,
                            top: 6,
                            child: CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              child: Text(
                                '!',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF030655),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userDataStream,
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.width * (9 / 16),
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  items: [
                    "assets/images/Add a heading.jpg",
                    "assets/images/ADD.jpg",
                    "assets/images/Empower.jpg",
                  ].map((imagePath) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.width * (9 / 16),
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 19),
              child: Text(
                "Revenue Section",
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: 460,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(right: 90),
                  child: MyPieChart(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 19),
              child: Text(
                "Daily collection",
                style: GoogleFonts.poppins(fontSize: 22, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Totalpricecontainer(),
            ),
          ],
        ),
      ),
    );
  }
}

void checkLowStockItems(BuildContext context) async {
  final List<Itempage> itemList = await getitem();
  List<Itempage> lowStockItems = getLowStockItems(itemList);

  if (lowStockItems.isNotEmpty) {
    hasNotificationsNotifier.value = true;

    // ignore: use_build_context_synchronously
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Outofstock(
        lowstockitems: lowStockItems,
      ),
    ));
  }
}

List<Itempage> getLowStockItems(List<Itempage> items) {
  return items.where((item) {
    int stockValue = int.tryParse(item.availablestock.toString()) ?? 0;
    return stockValue < 5;
  }).toList();
}
