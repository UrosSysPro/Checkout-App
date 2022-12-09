import 'package:check_out_app/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'dart:developer';


void main() async {
//     // WidgetsFlutterBinding.ensureInitialized();
//     // await Firebase.initializeApp(
//     // options: DefaultFirebaseOptions.currentPlatform,
//     // );
//     // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//     // print(analytics);
  // var jsonData=await loadJson("assets/getReceiptsForUser.json");
  // loadReceipts(jsonData);
  WidgetsFlutterBinding.ensureInitialized();

  // Put your Dynamsoft Barcode Reader license here.
  const String licenseKey =
      'DLS2eyJoYW5kc2hha2VDb2RlIjoiMTAxNTE4OTE4LVRYbE5iMkpwYkdWUWNtOXFYMlJpY2ciLCJvcmdhbml6YXRpb25JRCI6IjEwMTUxODkxOCIsImNoZWNrQ29kZSI6MjgxMzg4Nzd9';

  // Initialize the license so that you can use full feature of the Barcode Reader module.
  try {
    await DCVBarcodeReader.initLicense(licenseKey);
  } catch (e) {
    print(e);
  }

  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Check out",
    home: WelcomePage(),
  ));
}