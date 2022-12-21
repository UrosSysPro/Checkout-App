import 'dart:io';

import 'package:check_out_app/models/ReceiptModel.dart';
import 'package:check_out_app/models/UserModel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
UserModel? user;
FlutterSecureStorage? storage;

const url="checkoutbackend.azurewebsites.net";
const api="api/v1";

Future<void> loadUser() async{
  if(storage==null){
    storage=FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true)
    );
  }

  String? userString=await storage!.read(key: "user");
  if(userString==null){
    var requestUrl=Uri.https(url,"$api/users");
    var response=await http.post(requestUrl);
    userString=response.body;
    await storage?.write(key: "user", value: userString);
    print("created new user");
  }else{
    print("logged in");
  }

  print(userString);

  user=UserModel.fromJson(jsonDecode(userString));
}

Future<void> loadReceipts() async{
  receipts=[];
  if(user==null){
    print("user se nije ucitao kako treba");
    return;
  }

  var params={
    "page":"0",
    "limit":"10"
  };
  var resquestUrl=Uri.https(url,"$api/receipts",params);
  var headers={
    "userId":user!.id
  };
  var response=await http.get(resquestUrl,headers:headers,);
  print(response.body);
  List jsonList=jsonDecode(response.body);

  // String jsonString=await rootBundle.loadString("assets/getReceiptsForUser.json");
  // jsonList=jsonDecode(jsonString);
  for(int i=0;i<jsonList.length;i++){
    receipts.add(ReceiptModel.fromJson(jsonList[i]));
  }
}

Future<int> addReceipt(String receiptUrl) async{
  if(user==null){
    print("korisnik nije ucitan");
    return 500;
  }
  var queryParameters={
    "receiptURL":receiptUrl
  };
  var requestUrl=Uri.https(url,"$api/receipts",queryParameters);
  print(requestUrl);
  var headers={
    "userId":user!.id
  };
  print(headers["userId"]);
  var response=await http.post(requestUrl,headers: headers);
  print(response.statusCode);
  return response.statusCode;
}