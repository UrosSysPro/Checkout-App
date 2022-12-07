import 'package:flutter/material.dart';

class ExpandableSearch extends StatelessWidget {
  EdgeInsets? padding;
  BorderRadius? radius;
  FocusNode? focusNode;
  ExpandableSearch({ Key? key,this.padding,this.radius,this.focusNode }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: SizedBox(
            height: 40,
            child: TextField(
              focusNode: focusNode,
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
          borderRadius: radius??BorderRadius.circular(0),
          color: Colors.black12
        ),
      ),
    );
  }
}