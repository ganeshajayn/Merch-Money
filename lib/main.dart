import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:merchmoney/models/cartmodel.dart';
import 'package:merchmoney/models/categorypagemodel.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/models/profilescreen.dart';
import 'package:merchmoney/models/transactionmodel.dart';

import 'package:merchmoney/screen/innerscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  Hive.registerAdapter(CategorypageAdapter());
  Hive.registerAdapter(ItempageAdapter());
  Hive.registerAdapter(CartmodelAdapter());
  Hive.registerAdapter(TransactionmodelAdapter());
  Hive.registerAdapter(ProfilemodelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
