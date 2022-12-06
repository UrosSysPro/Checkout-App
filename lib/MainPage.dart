import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:check_out_app/CameraReaderWidget.dart';
import 'package:check_out_app/CollectionOverViewWidget.dart';
import 'package:check_out_app/CuponPage.dart';
import 'package:check_out_app/WelcomePage.dart';
import 'package:flutter/material.dart';

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
          child: const FlutterLogo(size:35)
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
        if(_selectedIndex==2)child=CuponPage();

        return child;
      }),

      // floatingActionButton: FloatingActionButton(
      //   child: Container(),
      //   onPressed: (){},
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
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
            label: "Overview",
            icon: Icon(Icons.home_repair_service)
          ),
          BottomNavigationBarItem(
            label: "Scanner",
            icon: Icon(Icons.receipt_long_rounded)
          ),
          BottomNavigationBarItem(
            label: "Cupons",
            icon: Icon(Icons.receipt)
          ),
        ],
        onTap: _onTap,
      ),
    );
  }
}