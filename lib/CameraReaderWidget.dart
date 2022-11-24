import 'package:flutter/material.dart';

class CameraReaderWidget extends StatelessWidget {
  const CameraReaderWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image(
          image: AssetImage("assets/stack-of-receipts.webp"),
          fit: BoxFit.cover,
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
                  
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}