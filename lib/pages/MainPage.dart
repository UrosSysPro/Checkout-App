import 'package:check_out_app/AppState.dart';
import 'package:check_out_app/customWidgets/CameraReaderWidget.dart';
import 'package:check_out_app/customWidgets/CollectionOverViewWidget.dart';
import 'package:check_out_app/customWidgets/LoadingAnimation.dart';
import 'package:check_out_app/customWidgets/LoyalityCardsPage.dart';
import 'package:check_out_app/pages/NoWiFiPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex=1;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onTap(int index){
    setState(() {
      _selectedIndex=index;
      // print(index);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>AppState(),
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 70,
          leading:Center(
            child: Hero(
              tag: "logo1",
              child: SvgPicture.asset("assets/logo.svg")
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.white, Colors.green]),
            ),
          ),
        ),
        
        body: Builder(builder: (context){
          Widget child=Container(color: Colors.red,);
          if(_selectedIndex==0)child=const CollectionOverViewWidget();
          // if(_selectedIndex==1)child=const CameraReaderWidget();
          if(_selectedIndex==2)child=const LoyalityCardsPage();
          
          return Stack(
            fit: StackFit.expand,
            children: [
              const Opacity(
                opacity: 0.1,
                child: Image(
                  image: AssetImage("assets/background.webp"),
                  // fit: BoxFit.fitWidth,
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child,
              LoadingAnimation()
            ],
          );
        }),

        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black54,
          iconSize: 30,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(            
              label: "Racuni",
              icon: SvgPicture.asset(
                "assets/receipts.svg",
                color: _selectedIndex==0?Colors.green:Colors.black54,
              )
            ),
            BottomNavigationBarItem(
              label: "Skener",
              icon: SvgPicture.asset("assets/scanner.svg",
                color: _selectedIndex==1?Colors.green:Colors.black54,
              )
            ),
            // BottomNavigationBarItem(
            //   label: "Popusti",
            //   icon: SvgPicture.asset("assets/cupons.svg",
            //     color: _selectedIndex==2?Colors.green:Colors.black54,
            //   )
            // ),
            // BottomNavigationBarItem(
            //   label: "Kartice",
            //   icon: Icon(Icons.card_giftcard,size: 40,)
            // ),
          ],
          onTap: _onTap,
        ),
      ),
    );
  }
}