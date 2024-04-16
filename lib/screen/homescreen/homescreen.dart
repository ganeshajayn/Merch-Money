import 'package:flutter/material.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/screen/homescreen/outofstock.dart';
import 'package:merchmoney/service/authservice.dart';
import 'package:merchmoney/widgets/pichart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/helper/helperfunctions.dart';
import 'package:merchmoney/screen/categoryscreen/searchresults.dart';
import 'package:merchmoney/screen/destinationfolder/functions.dart';

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
  AuthService authService = AuthService();
  bool hasNotifications = false; // Track notification state

  @override
  void initState() {
    super.initState();
    gettingUserdata();
  }

  gettingUserdata() async {
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        username = val!;
      });
    });
  }

  void checklowstockitems() async {
    final List<Itempage> itemlist = await getitem();
    List<Itempage> lowstockitems = getLowStockItems(itemlist);
    if (lowstockitems.isNotEmpty) {
      setState(() {
        hasNotifications = true; // Set notification state to true
      });

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Outofstock(
          lowstockitems: lowstockitems,
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              padding: const EdgeInsets.only(top: 30, left: 20),
              child: Text(
                "Hi $username",
                style: GoogleFonts.poppins(
                  fontSize: 29,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        }
        return Container(); // Return an empty container if no data is available
      },
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
            color: Colors.black,
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
                    color: hasNotifications ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    checklowstockitems();
                  },
                ),
                if (hasNotifications)
                  const Positioned(
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
                  ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userDataStream,
          SizedBox(height: height * 0.2),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MyPieChart(),
          ),
        ],
      ),
    );
  }
}
