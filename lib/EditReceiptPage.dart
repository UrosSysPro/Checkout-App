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
          Text(widget.receiptAsString,
            style: TextStyle(
              fontSize: 13
            ),
          ),
          QrImage(data: widget.model.url)
        ],
      ),
    );
  }
}