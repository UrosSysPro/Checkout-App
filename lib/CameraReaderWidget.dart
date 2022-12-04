

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CameraReaderWidget extends StatefulWidget {
  const CameraReaderWidget({ Key? key }) : super(key: key);

  @override
  State<CameraReaderWidget> createState() => _CameraReaderWidgetState();
}

class _CameraReaderWidgetState extends State<CameraReaderWidget> {
  var cameraController=MobileScannerController(torchEnabled: false);
  var popUpOpened=false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          fit: BoxFit.cover,
          allowDuplicates: false,
          controller:cameraController,
          onDetect: (barCode,args){
            if(barCode.rawValue==null){
              if(!popUpOpened){
                
              }
            }else{
              if(!popUpOpened) {
                showAddReceiptPopUp(barCode.rawValue!);
              }
            }
          },
        ),
        Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                  width: 5
                ),
                borderRadius: BorderRadius.circular(35)
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white
              ),
              child: IconButton(
                iconSize: 50,
                color: Colors.orange[900],
                icon:const Icon(Icons.bolt_outlined),
                onPressed: (){
                  cameraController.toggleTorch();
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  void incorrectQrCode(){
    popUpOpened=true;
    var res=showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Ne Radi:("),
        actions: [
          ElevatedButton(onPressed: (){Navigator.pop(context);}, child: const Text("jbg"))
        ],
      );
    });
    res.whenComplete(() => popUpOpened=false);
  }

  void showAddReceiptPopUp(String value){
    popUpOpened=true;
    var res=showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context, builder: (context){
        return Wrap(
          children: [
            StatefulBuilder(
              builder: (context,setState) {
                double padding=MediaQuery.of(context).viewInsets.bottom;
                return Padding(padding: EdgeInsets.only(top:8,left: 8,right: 8,bottom: padding),
                  child: Container(
                    child: Padding(padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          closeButton(context),
                          receiptTitle("Maxi"),
                          qrCode(value),
                          const SizedBox(height: 20,),
                          nameEdit(),
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
    res.whenComplete(() => popUpOpened=false);
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
      child: const Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: SizedBox(
          height: 40,
          child: TextField(
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: "Ime Racuna",
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black12
      ),
    );
  }
  Widget addReceiptButton(BuildContext context){
    return ElevatedButton(
      onPressed: (){Navigator.pop(context);},
      child: const SizedBox(
        width: 10000,
        height: 40,
        child: Center(child: Text("Dodaj")),
      )
    );
  }
}