import 'package:check_out_app/receipt/ReceiptModel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiptView extends StatelessWidget {
  final PageController controller;
  final double translate,scale;
  final int id;
  final ReceiptModel model;


  const ReceiptView(
    this.model,
    this.id,
    this.controller,
    this.translate,
    this.scale,
    { Key? key }
  ) : super(key: key);

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
    // string+="=======FISKALNI RACUN======\n";
    // string+=model.prodavnica+"\n";
    // string+=model.adresa+"\n";
    // string+="kasir:      smena1\n";
    // string+="=====PROMET PRODAJA=====\n";
    // string+="Artikli\n";
    // string+="==================================\n";
    // string+="=Naziv   Cena     Kol.      Ukupno=\n";
    // for(Artikal a in model.artikli){
    //   string+="${a.naziv}  ${a.cena}  ${a.kolicina}  ${a.cena*a.kolicina}\n";
    // }

    for(int i=0;i<1000;i++){
      string+="aaaa";
    }


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