import 'package:flutter/material.dart';

class ExpandableSearch extends StatelessWidget {
  EdgeInsets? padding;
  BorderRadius? radius;
  FocusNode? focusNode;
  String? hint;
  String? value;
  ExpandableSearch({ Key? key,this.value,this.padding,this.radius,this.focusNode,this.hint }) : super(key: key);

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
            child: TextFormField(
              initialValue: value??"",
              focusNode: focusNode,
              style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  
                  hintText: hint??"🔍 Search",
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: radius??BorderRadius.circular(0),
          color: Color(0xffdddddd)
        ),
      ),
    );
  }
}