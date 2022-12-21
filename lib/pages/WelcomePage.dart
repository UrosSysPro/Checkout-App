import 'dart:convert';

import 'package:check_out_app/customWidgets/FourCornerRectangle.dart';
import 'package:check_out_app/pages/MainPage.dart';
import 'package:check_out_app/RestApi.dart';
import 'package:check_out_app/main.dart';
import 'package:check_out_app/models/ReceiptModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

class WelcomePage extends StatefulWidget {


  const WelcomePage({ Key? key }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {

  

  late AnimationController controller;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

    controller=new AnimationController(vsync: this,duration: Duration(milliseconds: 200));
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
    loadUser().whenComplete(
      () => loadReceipts().whenComplete(
        () => controller.forward()
      )
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // controller.dispose();
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
            width: 200,height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(child: FourCornerRectangle(180, 180)),
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/logo.svg"),
                      SvgPicture.asset("assets/CheckOut.svg"),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(230),
              borderRadius: BorderRadius.circular(30)
            ),
          ),
        )
      ]
    );
  }
}