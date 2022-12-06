
import 'package:flutter/material.dart';

class CuponPage extends StatefulWidget {
  const CuponPage({ Key? key }) : super(key: key);

  @override
  _CuponPageState createState() => _CuponPageState();
}

class _CuponPageState extends State<CuponPage> {
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: 21,
      itemBuilder: (context, index) {
        if(index%2==0)
          return SizedBox(height: 30,);
        else
          return CuponView();
      }
    );
  }
}

class CuponView extends StatelessWidget {
  const CuponView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0,5),
            color: Colors.black26,
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(child: FlutterLogo(size: 60),flex: 1,),
            
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Row(
                  children: [
                    Expanded(child: 
                      Column(children: [
                        bigText("-27%", Colors.red),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: 50,
                            child: Image(fit:BoxFit.cover,image:AssetImage("assets/index.png"))
                          ),
                        ),
                      ],),
                      flex: 2,
                    ),
                    Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bigText("47999rsd", Colors.black),
                          prodavnicaText("Gigatron")
                        ],
                      ),
                      flex: 3,
                    ),
                    
                  ],
                ),flex: 1,),
                grayText("Valid until 25 November 2022")
              ],
            ),flex: 3,)
          ],
        ),
      ),
    );
  }
  Widget bigText(String value,Color color){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(value,
        style: TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
  Widget prodavnicaText(String value){
    return Padding(
      padding: EdgeInsets.symmetric(
        // horizontal: 10,
      ),
      child: Text(value,
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget grayText(String value){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15,left: 10),
      child: Text(value,
        style: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.bold,
          fontSize: 10
        ),
      ),
    );
  }
}