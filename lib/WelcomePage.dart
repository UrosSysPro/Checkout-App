import 'package:check_out_app/MainPage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return MainPage();
            }
          )
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children:[ 
          Container(
            child: const Image(
              image: AssetImage("assets/stack-of-receipts.webp"),
              fit:BoxFit.cover,
            )
          ),
          Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: FlutterLogo(size:150),
              ),
              decoration: BoxDecoration(
                color: Colors.black26.withAlpha(150),
                borderRadius: BorderRadius.circular(30)
              ),
            ),
          )
        ]
      ),
    );
  }
}