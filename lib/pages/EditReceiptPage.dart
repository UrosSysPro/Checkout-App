import 'package:check_out_app/customWidgets/ExpandableSearch.dart';
import 'package:check_out_app/models/ReceiptModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

import 'package:qr_flutter/qr_flutter.dart';

class EditReceiptPage extends StatefulWidget {
  final ReceiptModel model;
  late final String receiptAsString;
  EditReceiptPage({ Key? key,required this.model }) : super(key: key){
    receiptAsString=model.printReceipt();
  }

  @override
  _EditReceiptPageState createState() => _EditReceiptPageState();
}

class _EditReceiptPageState extends State<EditReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 70,
        leading:GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: Center(
            child: Transform.rotate(
              angle: math.pi,
              child: Hero(
                tag: "logo",
                child: SvgPicture.asset("assets/logo.svg")
              )
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Colors.white, Colors.green]),
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share), splashRadius: 20,),
          IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline),splashRadius: 20,),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(widget.receiptAsString,
              style: TextStyle(
                fontSize: 13,
                fontFamily: "monospace",
              ),
            ),
          ),
          QrImage(data: widget.model.url),
          Text("==================================="),
          ElevatedButton(
            onPressed: (){
              showAddReceiptPopUp(widget.model.name);
            },
            child: SizedBox(height: 40,
              child: Center(child: Text("Izmeni",style: TextStyle(fontSize: 15),)),
            ),
            
          )
        ],
      ),
    );
  }


  void showAddReceiptPopUp(String value){
    var res=showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context, builder: (context){
        return Wrap(
          children: [
            StatefulBuilder(
              builder: (context,setState) {
                double padding=MediaQuery.of(context).viewInsets.bottom+8;
                return Padding(padding: EdgeInsets.only(top:8,left: 8,right: 8,bottom: padding),
                  child: Container(
                    child: Padding(padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          closeButton(context),
                          receiptTitle("Novo ime"),
                          const SizedBox(height: 20,),
                          nameEdit(value),
                          const SizedBox(height: 20,),
                          addReceiptButton(context)
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                );
              }
            ),
          ],
        );
      }
    );
  }
  Widget closeButton(BuildContext context){
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: (){Navigator.pop(context);},
        child: Container(
          child:  const Padding(
            padding: EdgeInsets.all(3.0),
            child: Icon(Icons.close,size: 20,),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black26
          ),
        ),
      ),
    );
  }
  Widget receiptTitle(String value){
    return Align(
      alignment: Alignment.center,
      child: Text(value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),
      ),
    );
  }
  Widget qrCode(String value){
    return Padding(padding: const EdgeInsets.only(left: 60,right: 60),
      child: QrImage(data: value,),
    );
  }
  Widget nameEdit(String value){
    return ExpandableSearch(
      value: value,
      hint: "",
      radius: BorderRadius.circular(15),);
  }
  Widget addReceiptButton(BuildContext context){
    return ElevatedButton(
      onPressed: (){
        // updateReceipt(widget.model.id, )
        Navigator.pop(context);  
      },
      child: const SizedBox(
        width: 10000,
        height: 40,
        child: Center(child: Text("Izmeni")),
      )
    );
  }
}