import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CameraReaderWidget extends StatefulWidget {
  const CameraReaderWidget({ Key? key }) : super(key: key);

  @override
  State<CameraReaderWidget> createState() => _CameraReaderWidgetState();
}

class _CameraReaderWidgetState extends State<CameraReaderWidget> {

  bool enableTorch=false;
  bool popUpOpened=false;

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
              showAddReceiptPopUp(barCode.rawValue!);
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
                    showAddReceiptPopUp("google.com");
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  void showAddReceiptPopUp(String value){
    popUpOpened=true;
    showModalBottomSheet(
      context: context, builder: (context){
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 60),
              child: QrImage(data: value),
            ),
            Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "🔍 Search",
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){
                    popUpOpened=false;
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: 1000,
                    height: 40,
                    child: Center(child: Text("Dodaj"),)
                  )
                )
              ],
            )
          ],),
        );
      }
    );
  }
}