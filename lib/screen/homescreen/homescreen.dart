import 'package:flutter/material.dart';
import 'package:merchmoney/screen/categoryscreen/searchresults.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF030655),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchhedResults(),
              ));
            },
            icon: const Icon(Icons.search)),
      ),
      backgroundColor: const Color(0xFF030655),
    );
  }
}
