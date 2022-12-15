import 'dart:ui';

import 'package:flutter/material.dart';

class LoyalityCardsPage extends StatefulWidget {
  const LoyalityCardsPage({ Key? key }) : super(key: key);

  @override
  State<LoyalityCardsPage> createState() => _LoyalityCardsPageState();
}

class _LoyalityCardsPageState extends State<LoyalityCardsPage> {
  late ScrollController controller;
  double offset=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=ScrollController();
    controller.addListener(_onScroll);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.removeListener(_onScroll);
    controller.dispose();
  }

  void _onScroll(){
    setState(() {
      offset=controller.offset;
      // print(offset);
    });
  }


  @override
  Widget build(BuildContext context) {
    // var colors=[
    //   Colors.red,
    //   Colors.green,
    //   Colors.blue,
    //   Colors.yellow,
    //   Colors.teal,
    //   Colors.greenAccent,
    //   Colors.indigo
    // ];
    var kartice=[
      "assets/tehnomedia.png",
      "assets/burito.png",
      "assets/pica.jpg",
      "assets/extrasport.png"
    ];
    var imena=[
      "Tehnomedia",
      "Burito Madre",
      "Pizza Bar",
      "Extra Sport"
    ];
    double cardHeight=220;
    double stop=00;
    
    List<Widget> widgets=[];
    for(int i=0;i<kartice.length;i++){
      double pos=i*cardHeight-offset-stop;
      double offsetY=0;
      if(pos<0){
        offsetY=-pos/1.2;
        
      }
      int index=i;
      widgets.add(Transform.translate(
        offset: Offset(0,0),
        child: SizedBox(
          height: cardHeight,
          child: Padding(
            padding: const EdgeInsets.only(bottom:20.0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image(
                    image: AssetImage(kartice[index]),
                    fit: BoxFit.cover,
                  ),
                  
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5,
                          sigmaY: 5,
                      ),
                      child:Container(
                        width: 1000,
                        padding: EdgeInsets.only(top: 10,left: 10),
                        child: Text(imena[index],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold  
                          ),
                        ),
                        height: 70,
                        decoration:BoxDecoration (
                          color: Colors.white24
                        ),
                      ),
                    ),
                  )
                )
                ],
              ),
              // height: 200,
              decoration: BoxDecoration(
                // color: colors[i],
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 4,
                    offset: Offset(0,3)
                  )
                ]
              ),
            ),
          ),
        ),
      ));
    }


    return ListView(
      controller: controller,
      padding: EdgeInsets.all(20),
      
        children:[ Column(children: widgets,)]
        
   );
  }
}