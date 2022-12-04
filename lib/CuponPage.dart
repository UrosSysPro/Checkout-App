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
      itemCount: 10,
      itemBuilder: (context, index) {
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
        boxShadow: [
          BoxShadow(blurRadius: 30,)
        ]
      ),
    );
  }
}