import 'package:check_out_app/CameraReaderWidget.dart';
import 'package:check_out_app/CollectionOverViewWidget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex=1;

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
        if(_selectedIndex==2)child=Container(color: Colors.blue,);

        return child;
      }),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        // showUnselectedLabels: false,
        // showSelectedLabels: false,
        currentIndex: _selectedIndex,
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