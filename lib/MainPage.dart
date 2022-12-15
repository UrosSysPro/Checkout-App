import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:check_out_app/CameraReaderWidget.dart';
import 'package:check_out_app/CollectionOverViewWidget.dart';
import 'package:check_out_app/CuponPage.dart';
import 'package:check_out_app/LoyalityCardsPage.dart';
import 'package:check_out_app/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return Scaffold(
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
        if(_selectedIndex==0)child=CollectionOverViewWidget();
        if(_selectedIndex==1)child=CameraReaderWidget();
        // if(_selectedIndex==2)child=CuponPage();
        if(_selectedIndex==2)child=LoyalityCardsPage();

        return Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.1,
              child: Image(
                image: AssetImage("assets/background.webp"),
                // fit: BoxFit.fitWidth,
                repeat: ImageRepeat.repeat,
              ),
            ),
            child
          ],
        );
      }),

      // floatingActionButton: FloatingActionButton(
      //   child: Container(),
      //   onPressed: (){},
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black54,
        iconSize: 30,
        // showUnselectedLabels: false,
        // showSelectedLabels: false,
        currentIndex: _selectedIndex,
        // icons: [Icons.home_repair_service,Icons.receipt_long_rounded,Icons.receipt],
        // notchSmoothness: NotchSmoothness.defaultEdge,
        // leftCornerRadius: 32,
        // rightCornerRadius: 32,
        // gapLocation: GapLocation.center,
        // fixedColor: Colors.green,
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
          BottomNavigationBarItem(
            label: "Kartice",
            icon: Icon(Icons.card_giftcard,size: 40,)
          ),
        ],
        onTap: _onTap,
      ),
    );
  }
}