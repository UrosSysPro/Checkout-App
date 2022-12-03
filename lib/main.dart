import 'package:check_out_app/MainPage.dart';
import 'package:check_out_app/WelcomePage.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'dart:developer';


void main() async {
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    // );
    // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // print(analytics);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Check out",
    home: MainPage(),
  ));
}

