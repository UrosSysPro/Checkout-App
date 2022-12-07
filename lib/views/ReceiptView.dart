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
            style: TextStyle(
              fontSize: 9
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