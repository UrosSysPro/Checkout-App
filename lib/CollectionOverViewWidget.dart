import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class CollectionOverViewWidget extends StatefulWidget {
  const CollectionOverViewWidget({ Key? key }) : super(key: key);

  @override
  _CollectionOverViewWidgetState createState() => _CollectionOverViewWidgetState();
}

class _CollectionOverViewWidgetState extends State<CollectionOverViewWidget> {
  
  late final PageController scrollController;
  double scrollOffset=0;
  double pageViewFraction=0.5;
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController=PageController(viewportFraction: pageViewFraction);
    scrollController.addListener(_onScroll);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  void _onScroll(){
    // print(scrollController.offset);
    setState(() {
      scrollOffset=scrollController.offset;
      // print(scrollController.offset);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: receiptsList(),flex: 1,),
        info(),
        search()
      ],
    );
  }

  

  
  Widget receiptsList(){

    List<Widget> widgets=[];
    List<Color> colors=[
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.cyan,
      Colors.lime,
      Colors.purple
    ];
    double screenWidth=MediaQuery.of(context).size.width*pageViewFraction;
    for(int i=0;i<colors.length;i++){
      double scale=i*screenWidth-scrollOffset;
      scale=scale>0?scale:-scale;
      double translate=10-scale/10;
      // translate=20;//obrisati
      scale/=800;
      scale=1.0-scale;
      scale=max(0, scale*0.9);
      // scale=0.8;//obrisati
      widgets.add(ReceiptListItem(colors[i],screenWidth,scale,translate,scrollController,i));
    }
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widgets.length,
      controller: scrollController,
      itemBuilder: (context,index){
        return widgets[index];
    });
  } 

  Widget info(){
    FontWeight weight=FontWeight.bold;
    double fontSize=25;
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
  
  Widget search(){
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
      child: Container(
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
    );
  }

}

class ReceiptListItem extends StatelessWidget {
  final Color color;
  final double scale;
  final double width;
  final double translate;
  final PageController controller;
  final int id;
  const ReceiptListItem(this.color,this.width,this.scale,this.translate,this.controller,this.id,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.animateToPage(id, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Transform.translate(
        offset: Offset(0,translate),
        child: Transform.scale(
          scale: scale,
          child: SizedBox(
            width:width,
            child: Container(
              clipBehavior: Clip.none,
              child: Align(
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0,-25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff515151)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlutterLogo(size: 50),
                    ),
                  )
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}