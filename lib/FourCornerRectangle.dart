import 'package:flutter/material.dart';

class FourCornerRectangle extends StatelessWidget {
  final double width,height;
  const FourCornerRectangle(this.width,this.height,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        // color: Colors.green,
        border: Border.all(
          width: 4,
          color: Colors.black45
        )
      ),
    );
  }
}