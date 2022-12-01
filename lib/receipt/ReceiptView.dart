import 'package:check_out_app/receipt/ReceiptModel.dart';
import 'package:flutter/material.dart';

class ReceiptView extends StatelessWidget {
  final PageController controller;
  final double translate,width,scale;
  final int id;
  final ReceiptModel model;
  const ReceiptView(
    this.model,
    this.id,
    this.controller,
    this.translate,
    this.scale,
    this.width,
    { Key? key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.animateToPage(id, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Transform.translate(
        offset: Offset(0,translate),
        child: Transform.scale(
          scale: scale,
          child: SizedBox(
            width:width,
            child: Container(
              clipBehavior: Clip.none,
              child: Align(
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0,-25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff515151)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlutterLogo(size: 50),
                    ),
                  )
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                // color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}