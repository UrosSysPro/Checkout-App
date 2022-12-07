import 'package:check_out_app/ExpandableSearch.dart';
import 'package:check_out_app/models/ReceiptModel.dart';
import 'package:check_out_app/views/ReceiptView.dart';
import 'package:flutter/material.dart';
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
  late FocusNode focusNode;
  BorderRadius searchRadius=BorderRadius.circular(15);
  EdgeInsets searchPadding=EdgeInsets.symmetric(horizontal: 50,vertical: 20);
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController=PageController(viewportFraction: pageViewFraction);
    scrollController.addListener(_onScroll);
    focusNode=FocusNode();
    focusNode.addListener(_onFocusChange);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.removeListener(_onScroll);
    focusNode.removeListener(_onFocusChange);
    scrollController.dispose();
    focusNode.dispose();
  }

  void _onScroll(){
    // print(scrollController.offset);
    setState(() {
      scrollOffset=scrollController.offset;
      // print(scrollController.offset);
    });
  }
  void _onFocusChange(){
    setState(() {
      if(!focusNode.hasFocus){
        // print("true");
        searchRadius=BorderRadius.circular(15);
        searchPadding=EdgeInsets.symmetric(horizontal: 50,vertical: 20);
      }else{
        // print("false");
        searchRadius=BorderRadius.circular(0);
        searchPadding=EdgeInsets.all(0);
      }  
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
    double screenWidth=MediaQuery.of(context).size.width*pageViewFraction;
    
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: receipts.length,
      controller: scrollController,
      clipBehavior: Clip.none,
      itemBuilder: (context,index){
        double scale=index*screenWidth-scrollOffset;
        scale=scale>0?scale:-scale;
        double translate=10-scale/10;
        scale/=800;
        scale=1.0-scale;
        scale=max(0, scale*0.9);
        return ReceiptView(index,receipts[index],translate,scale,scrollController);
      }
    );
  } 

  Widget info(){
    FontWeight weight=FontWeight.bold;
    double fontSize=20;
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
    return ExpandableSearch(
      padding: searchPadding,
      radius: searchRadius,
      focusNode: focusNode,
    );
  }

}
