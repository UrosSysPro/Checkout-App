import 'dart:ui';

import 'package:check_out_app/EditReceiptPage.dart';
import 'package:check_out_app/models/ReceiptModel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiptView extends StatelessWidget {
  final PageController controller;
  final double translate,scale;
  final int id;
  final ReceiptModel model;
  final int selectedReceipt;
  late final String receiptAsString;
  ReceiptView(
    this.id,
    this.model,
    this.translate,
    this.scale,
    this.controller,
    this.selectedReceipt,{ Key? key }
  ) : super(key: key){
    receiptAsString=model.printReceipt();
  }

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(id==selectedReceipt)
          Navigator.push(context, MaterialPageRoute(builder:(context){
              return EditReceiptPage(model: model);
            } 
          ));
        else
          controller.animateToPage(id, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Transform.translate(
        offset: Offset(0,translate),
        child: Transform.scale(
          scale: scale,
          child: Stack(
            fit: StackFit.expand,
            children: [
              receiptList(),
              // Container(color: Colors.green,),
              logo()
            ],
          ),
        )
      ),
    );
  }

  Widget receiptList(){
    String string=receiptAsString;
    
    

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black54,
            offset: Offset(0,10),
            spreadRadius: -20
          )
        ]
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView(
        padding: EdgeInsets.all(8),
        children:[
          Text(string,
          textAlign: TextAlign.left,
            style: TextStyle(
              
              fontSize: 8,
              fontFamily: "monospace",
              fontFeatures: [
                FontFeature.tabularFigures()
              ]
            ),
          ),
          Image(
            image: AssetImage("assets/qr-code.png"),
          )
        ]
      ),
    );
  }
  Widget receiptText(String value){
    return Text(value,
      style: TextStyle(
        fontSize: 10,
      ),
    );
  }
  Widget logo(){
    late Widget logo;
    if(model.placeOfPurchase.business.logo.isNotEmpty){
      logo=ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Color(0xff777777),
          child: SizedBox(
            width: 60,
            height: 60,
            child: Image(
              image: AssetImage(model.placeOfPurchase.business.logo),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }else{
      logo=FlutterLogo(size: 50,);
    }
    return  Align(
      alignment: Alignment.topCenter,
      child: Transform.translate(
        offset: Offset(0,-25),
        child: logo
      ),
    );
  }
}