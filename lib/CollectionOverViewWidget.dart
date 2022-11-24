import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CollectionOverViewWidget extends StatefulWidget {
  const CollectionOverViewWidget({ Key? key }) : super(key: key);

  @override
  _CollectionOverViewWidgetState createState() => _CollectionOverViewWidgetState();
}

class _CollectionOverViewWidgetState extends State<CollectionOverViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: ListView(),flex: 1,),
        info(),
        TextField(
          decoration: InputDecoration(
            labelText: "Search",
            icon: Icon(Icons.search),
            border: OutlineInputBorder()
          ),
        )
      ],
    );
  }
  Column info(){
    FontWeight weight=FontWeight.bold;
    double fontSize=30;
    var decorationDark=TextStyle(
      fontSize: fontSize,
      color: Colors.black,
      fontWeight: weight
    );
    var decorationGray=TextStyle(
      fontWeight: weight,
      fontSize: fontSize,
      color: Colors.black54
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Maxi",style: decorationGray,),
            SizedBox(width: 5,),
            Text("6.10.2022",style: decorationDark,)],
        ),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("4500",style: decorationGray,),
            SizedBox(width: 5,),
            Text("RSD",style: decorationDark,)],
        ),
        SizedBox(height: 5,),
        Text("\"Posudje\"",style: decorationDark,),
        SizedBox(height: 5,),
      ]
    );
  }
}