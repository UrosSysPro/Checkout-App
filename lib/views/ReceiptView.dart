import 'package:check_out_app/models/ReceiptModel.dart';
import 'package:flutter/material.dart';

class ReceiptView extends StatelessWidget {
  final PageController controller;
  final double translate,scale;
  final int id;
  final ReceiptModel model;
  const ReceiptView(
    this.id,
    this.model,
    this.translate,
    this.scale,
    this.controller,{ Key? key }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
    String string="";
    
    int lineWidth=40;
    string+="============ ФИСКАЛНИ РАЧУН ============";


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
      child: SingleChildScrollView(
        child:Column(
          children: [
            Text(string,
              style: TextStyle(
                fontSize: 10
              ),
            ),
            // QrImage(data: model.code)
          ],
        )
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
    return  Align(
      alignment: Alignment.topCenter,
      child: Transform.translate(
        offset: Offset(0,-25),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff515151)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlutterLogo(size: 50),
          ),
        )
      ),
    );
  }
}