import 'package:check_out_app/MainPage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {


  const WelcomePage({ Key? key }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=new AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    controller.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context){
            return MainPage();
          })
        );
      }
    });
    controller.forward();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children:[ 
        Container(
          child: const Image(
            image: AssetImage("assets/stack-of-receipts.webp"),
            fit:BoxFit.cover,
          )
        ),
        Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: FlutterLogo(size:150),
            ),
            decoration: BoxDecoration(
              color: Colors.black26.withAlpha(150),
              borderRadius: BorderRadius.circular(30)
            ),
          ),
        )
      ]
    );
  }
}