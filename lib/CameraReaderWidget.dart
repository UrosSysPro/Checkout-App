import 'dart:ui';

import 'package:check_out_app/DynamSoftCamera.dart';
import 'package:check_out_app/ExpandableSearch.dart';
import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';



class CameraReaderWidget extends StatefulWidget {
  const CameraReaderWidget({ Key? key }) : super(key: key);

  @override
  State<CameraReaderWidget> createState() => _CameraReaderWidgetState();
}

class _CameraReaderWidgetState extends State<CameraReaderWidget> {
  // var cameraController=MobileScannerController(torchEnabled: false);
  var popUpOpened=false;
  var cameraKey=GlobalKey<DynamSoftCameraState>();


  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // MobileScanner(
        //   fit: BoxFit.cover,
        //   allowDuplicates: true,
        //   controller:cameraController,
        //   onDetect: (barCode,args){
        //     if(barCode.rawValue==null){
        //       if(!popUpOpened){
        //         incorrectQrCode();
        //       }
        //     }else{
        //       if(!popUpOpened) {
        //         showAddReceiptPopUp(barCode.rawValue!);
        //       }
        //     }
        //   },
        // ),
        DynamSoftCamera(showAddReceiptPopUp,key:cameraKey,),
        
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
              child: toggleFlashButton()
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
                          // qrCode(value),
                          Text(value),
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
    res.whenComplete(() {
      popUpOpened=false;
    });
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
    return ExpandableSearch(radius: BorderRadius.circular(15),);
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
  Widget toggleFlashButton(){
    return StatefulBuilder(builder: (context,setState){
      return  IconButton(
        iconSize: 50,
        color: Colors.orange[900],
        icon:Builder(builder: (context){
          var icon=Icon(Icons.flash_off_sharp);
          if(cameraKey.currentState!=null){
            if(cameraKey.currentState!.isTorchOn){
              icon=Icon(Icons.flash_on_sharp);
            }
          }
          return icon;
        },),
        onPressed: (){
          setState((){
            cameraKey.currentState?.toggleTorch();
          });
        },
      );
    });
  }
}