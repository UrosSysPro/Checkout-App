import 'package:check_out_app/AppState.dart';
import 'package:check_out_app/customWidgets/ExpandableSearch.dart';
import 'package:check_out_app/models/ReceiptModel.dart';
import 'package:check_out_app/views/ReceiptView.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class CollectionOverViewWidget extends StatefulWidget {
  const CollectionOverViewWidget({ Key? key }) : super(key: key);

  @override
  _CollectionOverViewWidgetState createState() => _CollectionOverViewWidgetState();
}

class _CollectionOverViewWidgetState extends State<CollectionOverViewWidget> {
  
  late final PageController scrollController;
  double scrollOffset=0;
  double pageViewFraction=0.6;
  late FocusNode focusNode;
  BorderRadius searchRadius=BorderRadius.circular(15);
  EdgeInsets searchPadding=EdgeInsets.symmetric(horizontal: 50,vertical: 20);
  int selectedReceipt=0;
 
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
    // if()
    var appState=context.watch<AppState>();
    return Column(
      children: [
        Expanded(child: receiptsList(appState),flex: 1,),
        info(appState),
        search(appState)
      ],
    );
  }

  

  
  Widget receiptsList(AppState appState){
    if(appState.receipts.isEmpty){
      return const Center(
        child: Text("Nema sacuvanih racuna"),
      );
    }

    double screenWidth=MediaQuery.of(context).size.width*pageViewFraction;
    
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: appState.receipts.length,
      controller: scrollController,
      clipBehavior: Clip.none,
      onPageChanged: (index){
        setState(() {
          selectedReceipt=index;
        });
      },
      itemBuilder: (context,index){
        double scale=index*screenWidth-scrollOffset;
        scale=scale>0?scale:-scale;
        double translate=10-scale/20;
        scale/=1100;
        scale=1.0-scale;
        scale=max(0, scale*0.9);
        return ReceiptView(index,appState.receipts[index],translate,scale,scrollController,selectedReceipt);
      }
    );
  } 

  Widget info(AppState appState){
    if(appState.receipts.isEmpty){
      return Container(height: 0,);
    }
    String prodavnica=appState.receipts[selectedReceipt].placeOfPurchase.business.name;
    String datum=appState.receipts[selectedReceipt].scanned;
    double total=appState.receipts[selectedReceipt].totalPrice;
    String valuta="RSD";
    String imeRacuna=appState.receipts[selectedReceipt].name;

    // if(prodavnica.length>10){
    //   prodavnica=prodavnica.substring(0,10)+"...";
    // }

    FontWeight weight=FontWeight.bold;
    double fontSize=18;
    var decorationDark=TextStyle(
      fontSize: fontSize,
      color: Colors.black,
      fontWeight: weight
    );
    var decorationGray=TextStyle(
      fontWeight: weight,
      fontSize: fontSize,
      color: Colors.black54,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 5,),
        SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  prodavnica,
                  style: decorationGray,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                )
              ),
              SizedBox(width: 5,),
              Text(datum.substring(0,10),style: decorationDark,)],
          ),
        ),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${total.toInt()}",style: decorationGray,),
            SizedBox(width: 5,),
            Text(valuta,style: decorationDark,)],
        ),
        SizedBox(height: 5,),
        Text("\"$imeRacuna\"",style: decorationDark,),
        SizedBox(height: 5,),
      ]
    );
  }
  
  Widget search(AppState appState){
    if(appState.receipts.isEmpty){
      return Container(height: 0,);
    }
    return ExpandableSearch(
      padding: searchPadding,
      radius: searchRadius,
      focusNode: focusNode,
    );
  }

}
