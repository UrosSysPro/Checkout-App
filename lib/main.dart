import 'package:check_out_app/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:developer';


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
    home: WelcomePage(),
  ));
}


// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// void main(){
//   runApp(new MaterialApp(
//     home: TestScreen(),
//   ));
  
// }

// class TestScreen extends StatelessWidget {
//   const TestScreen({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Mobile Scanner')),
//       body: MobileScanner(
//           allowDuplicates: false,
//           onDetect: (barcode, args) {
//             if (barcode.rawValue == null) {
//               showDialog(context: context, builder: (context){
//                 return AlertDialog(
//                   title: Text("Ne radi"),
//                   actions: [
//                     ElevatedButton(
//                       onPressed: (){
//                         Navigator.pop(context);
//                       },
//                       child: Text("Ok")
//                     )
//                   ],
//                 );
//               });
//             } else {
//               showDialog(context: context, builder: (context){
//                 return AlertDialog(
//                   title: Text("Radi"),
//                   content: Text(barcode.rawValue!),
//                   actions: [
//                     ElevatedButton(
//                       onPressed: (){
//                         Navigator.pop(context);
//                       },
//                       child: Text("Ok")
//                     )
//                   ],
//                 );
//               });
//             }
//           }),
//     );
//   }
// }