import 'package:check_out_app/AppState.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state=context.watch<AppState>();
    if(!state.loadingUser&&!state.loadingReceipts)return SizedBox();
    return Container(
      clipBehavior: Clip.hardEdge,
      child: Center(
        child:Container(
          child: LoadingAnimationWidget.inkDrop(color: Colors.black, size: 50),
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),  
        )
      ),
      decoration: BoxDecoration(
        color: Colors.black26
      ),
    );
  }
}