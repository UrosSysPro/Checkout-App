import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class FourCornerRectangle extends StatelessWidget {
  final double width,height;
  const FourCornerRectangle(this.width,this.height,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: const Radius.circular(30),
      borderType: BorderType.RRect,
      dashPattern: [width/3],
      child: SizedBox(
        width: width,
        height: height,
      )
    );
  }
}