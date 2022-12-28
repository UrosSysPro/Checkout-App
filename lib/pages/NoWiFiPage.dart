import 'package:flutter/material.dart';

class NoWiFiPage extends StatelessWidget {
  const NoWiFiPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: (){
          // ping();
        },
        child: Text("Refresh"),
      ),
    );
  }
}