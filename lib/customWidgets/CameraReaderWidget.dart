import 'dart:ui';

import 'package:check_out_app/customWidgets/AddReceiptPopUp.dart';
import 'package:check_out_app/customWidgets/DynamSoftCamera.dart';
import 'package:check_out_app/customWidgets/ExpandableSearch.dart';
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
        DynamSoftCamera(key:cameraKey,),
        
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