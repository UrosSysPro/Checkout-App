import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraReaderWidget extends StatefulWidget {
  const CameraReaderWidget({ Key? key }) : super(key: key);

  @override
  State<CameraReaderWidget> createState() => _CameraReaderWidgetState();
}

class _CameraReaderWidgetState extends State<CameraReaderWidget> {

  bool enableTorch=false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          fit: BoxFit.cover,
          controller: MobileScannerController(
            torchEnabled: enableTorch
          ),
          onDetect: (barCode,args){
            if(barCode.rawValue==null){
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Text("Ne Radi:("),
                  actions: [
                    ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("jbg"))
                  ],
                );
              });
            }else{
                
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
                icon:Icon(Icons.bolt_outlined),
                onPressed: (){
                  setState(() {
                    enableTorch=!enableTorch;
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}