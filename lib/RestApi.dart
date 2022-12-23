import 'dart:io';

import 'package:check_out_app/models/ReceiptModel.dart';
import 'package:check_out_app/models/UserModel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
UserModel? user;
FlutterSecureStorage? storage;
bool imaInterneta=true;

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
    if(response.statusCode==200){
      imaInterneta=true;
      userString=response.body;
      await storage?.write(key: "user", value: userString);
    }else{
      imaInterneta=false;
    }
  }else{
    user=UserModel.fromJson(jsonDecode(userString));
  }
  await ping();
}

Future<void> loadReceipts() async{
  receipts=[];
  if(user==null){
    print("user se nije ucitao kako treba");
    return;
  }

  var params={
    "page":"0",
    "limit":"100"
  };
  var resquestUrl=Uri.https(url,"$api/receipts",params);
  var headers={
    "userId":user!.id
  };
  var response=await http.get(resquestUrl,headers:headers,);
  if(response.statusCode==200){
    imaInterneta=true;
    print(response.body);
    List jsonList=jsonDecode(response.body);

  // String jsonString=await rootBundle.loadString("assets/getReceiptsForUser.json");
  // jsonList=jsonDecode(jsonString);
    for(int i=0;i<jsonList.length;i++){
      receipts.add(ReceiptModel.fromJson(jsonList[i]));
    }
  }else{
    imaInterneta=false;
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
  imaInterneta=response.statusCode==200;
  print(response.statusCode);
  return response.statusCode;
}

Future<int> updateReceipt(int id,String name)async{
  var requestUrl=Uri.https(url,"$api/receipts");
  var requestBody={
    "id": id,
    "warranty": true,
    "name": name,
    "validUntil": "2023-12-25"
  };
  var response=await http.put(requestUrl,body: requestBody);
  imaInterneta=response.statusCode==200;
  return response.statusCode;
}

Future<int> ping()async{

  var ping=await http.get(Uri.https(url,"/$api/users"));
  imaInterneta=ping.statusCode==200;
  return ping.statusCode;
}