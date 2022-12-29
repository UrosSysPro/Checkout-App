
import 'package:check_out_app/models/ReceiptModel.dart';
import 'package:check_out_app/models/UserModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppState with ChangeNotifier{
  UserModel? user;
  List<ReceiptModel> receipts=[];
  bool loadingUser=false;
  bool loadingReceipts=false;
  bool waitingForAnyRequest=false;
  bool imaInterneta=true;
  FlutterSecureStorage? storage;
  static const url="checkoutbackend.azurewebsites.net";
  static const api="api/v1";

  AppState(){
    loadingReceipts=false;
    loadingUser=false;
    waitingForAnyRequest=false;
    loadUser().then((value) => loadReceipts());
  }

  Future<void> loadUser() async{
    if(storage==null){
      storage=const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true)
      );
    }
    loadingUser=true;
    notifyListeners();
    String? userString=await storage!.read(key: "user");
    if(userString==null){
      var requestUrl=Uri.https(url,"$api/users");
      var response=await httpPost(requestUrl);

      imaInterneta=response.statusCode==200;
      if(response.statusCode==200){
        userString=response.body;
        await storage?.write(key: "user", value: userString);
        print(userString);
      }
    }else{
      user=UserModel.fromJson(jsonDecode(userString));
      print(userString);
    }
    loadingUser=false;
    notifyListeners();
  }


  Future<void> loadReceipts() async{
    loadingReceipts=true;
    notifyListeners();
    receipts=[];
    if(user==null){
      print("user se nije ucitao kako treba");
      loadingReceipts=false;
      notifyListeners();
      return;
    }

    var params={
      "page":"0",
      "limit":"100"
    };
    var headers={
      "userId":user!.id
    };
    var resquestUrl=Uri.https(url,"$api/receipts",params);
    var response=await httpGet(resquestUrl,headers:headers,);
    
    imaInterneta=response.statusCode==200;
    if(response.statusCode==200){
      receipts=[];
      print(response.body);
      List jsonList=jsonDecode(response.body);

    // String jsonString=await rootBundle.loadString("assets/getReceiptsForUser.json");
    // jsonList=jsonDecode(jsonString);
      for(int i=0;i<jsonList.length;i++){
        receipts.add(ReceiptModel.fromJson(jsonList[i]));
      }
    }
    loadingReceipts=false;
    notifyListeners();
  }


  Future<int> addReceipt(String receiptUrl) async{
    if(user==null){
      return 500;
    }
    waitingForAnyRequest=true;
    notifyListeners();
    var queryParameters={
      "receiptURL":receiptUrl
    };
    var requestUrl=Uri.https(url,"$api/receipts",queryParameters);
    print(requestUrl);
    Map<String,String> headers={
      "userId":user!.id
    };
    print(headers["userId"]);
    var response=await httpPost(requestUrl,headers: headers);
    
    imaInterneta=response.statusCode==200||response.statusCode==409||response.statusCode==500;
    print(response.statusCode);
    waitingForAnyRequest=false;
    notifyListeners();
    return response.statusCode;
  }

  Future<int> updateReceipt(int id,String name)async{
    waitingForAnyRequest=true;
    notifyListeners();
    var requestUrl=Uri.https(url,"$api/receipts");
    var requestBody={
      "id": id,
      "warranty": true,
      "name": name,
      "validUntil": "2023-12-25"
    };
    var response=await httpPut(requestUrl,body: requestBody);
    imaInterneta=response.statusCode==200;
    waitingForAnyRequest=false;
    notifyListeners();
    return response.statusCode;
  }

  Future<int> ping()async{

    var ping=await httpGet(Uri.https(url,"/$api/users"));
    imaInterneta=ping.statusCode==200;
    return ping.statusCode;
  }
}


Future<http.Response> httpGet(Uri url,{Object? body,Map<String,String>?headers})async{
  
  try{
    return await http.get(url,headers: headers).timeout(
      Duration(seconds: 3),
      onTimeout: ()=>fakeResponse()
    );
  }catch(e){
    return fakeResponse();
  }
  
}

Future<http.Response> httpPost(Uri url,{Object? body,Map<String,String>?headers})async{
  try{
    return await http.post(
      url,
      headers: headers,
      body: body
    ).timeout(
      Duration(seconds: 3),
      onTimeout: ()=>fakeResponse()
    );
  }catch(e){
    return fakeResponse();
  }
}

Future<http.Response> httpPut(Uri url,{Object? body,Map<String,String>?headers})async{
  try{
    return await http.post(
      url,
      headers: headers,
      body: body
    ).timeout(
      Duration(seconds: 3),
      onTimeout: ()=>fakeResponse()
    );
  }catch(e){
    return fakeResponse();
  }
}

http.Response fakeResponse(){
  return http.Response("timeout",404);
}