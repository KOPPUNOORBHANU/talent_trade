
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:talent_trade/views/entry/entryScreen.dart';
// import 'package:talent_trade/views/home/home.dart';
// import 'package:talent_trade/views/home/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options:const FirebaseOptions(
      apiKey: "AIzaSyC50UAnmEGnXN3Qi6pMfDIT7gVKaqCzrSY", 
      appId: "1:870836559603:android:79c59ce61786e1e6cee186", 
      messagingSenderId: "870836559603", 
      projectId: "talent-trade"),
    );
  }

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talent Trade',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: EntryScreen(),  //EntryScreen() need to be add after testing with the screens
    );
  }
}
