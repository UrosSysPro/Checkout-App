
import 'dart:async';

import 'package:check_out_app/customWidgets/ExpandableSearch.dart';
import 'package:check_out_app/RestApi.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddReceiptPopUp extends StatefulWidget {
  String receiptUrl;

  AddReceiptPopUp({ Key? key,required this.receiptUrl}) : super(key: key);

  @override
  _AddReceiptPopUpState createState() => _AddReceiptPopUpState();
}

class _AddReceiptPopUpState extends State<AddReceiptPopUp> {
  String receiptName="";

  late Future<int> status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status=addReceipt(widget.receiptUrl).then(responseArrived);
  }

  @override
  Widget build(BuildContext context) {
    double padding=MediaQuery.of(context).viewInsets.bottom;
    return FutureBuilder(
      future: status,
      builder: (context,AsyncSnapshot<int> snapshot) {
        Widget mainContent= Padding(padding: EdgeInsets.only(top:8,left: 8,right: 8,bottom: padding),
          child: Container(
            child: Padding(padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  closeButton(context),
                  receiptTitle("Racun"),
                  qrCode(widget.receiptUrl),
                  // Text(widget.receiptUrl),
                  const SizedBox(height: 20,),
                  nameEdit(),
                  const SizedBox(height: 20,),
                  addReceiptButton(context,snapshot.hasData)
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
        );

        return mainContent;
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
  Widget nameEdit(){
    return Container(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: SizedBox(
          height: 40,
          child: TextFormField(
            onChanged: (value){
              receiptName=value;
            },
            style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText:"Ime racuna",
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffdddddd)
      ),
    );
  }
  Widget addReceiptButton(BuildContext context,bool hasData){
    return ElevatedButton(
      onPressed: hasData?()async{
        Navigator.of(context).pop();
      }:null,
      child: const SizedBox(
        width: 10000,
        height: 40,
        child: Center(child: Text("Dodaj")),
      ),
      
    );
  }
  void showMessageBox(BuildContext context,String message){
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text(message),
        actions: [ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("ok"))],
      );
    }).whenComplete(() => Navigator.pop(context));
  }
  FutureOr<int> responseArrived(int status){
    if(status==409){
      showMessageBox(context, "neko je vec skenirao ovaj racun");
    }else if(status!=200){
      showMessageBox(context, "eror $status");
    }
    return status;
  }
}