import 'dart:js';

import 'package:check_out_app/AppState.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state=context.watch<AppState>();
    if(!state.loadingUser)return SizedBox();
    if(!state.loadingReceipts)return SizedBox();
    return Container(
      clipBehavior: Clip.hardEdge,
      child: Center(
        child:LoadingAnimationWidget.inkDrop(color: Colors.black, size: 50)
      ),
      decoration: BoxDecoration(
        color: Colors.black26
      ),
    );
  }
}