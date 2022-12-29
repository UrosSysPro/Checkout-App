import 'package:check_out_app/AppState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoWiFiPage extends StatelessWidget {
  const NoWiFiPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState=context.watch<AppState>();


    return Center(
      child: OutlinedButton(
        onPressed: (){
          appState.loadUser().then((value) => appState.loadReceipts());          

        },
        child: Text("Refresh"),
      ),
    );
  }
}