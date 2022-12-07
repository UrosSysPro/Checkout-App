import 'dart:convert';

import 'package:check_out_app/models/ArtikalModel.dart';
import 'package:check_out_app/models/PlaceOfPurchaseModel.dart';
import 'package:check_out_app/models/UserModel.dart';
import 'package:flutter/foundation.dart';

class ReceiptModel{
  int id;
  PlaceOfPurchaseModel placeOfPurchase;
  List<ArtikalModel> items;
  double totalPrice;
  bool cash;
  double paid;
  double tax;
  double totalTaxValue;
  String time;
  String invoiceNumber,invoiceCounter;
  UserModel user;
  bool deleted;
  String scanned;
  String name;
  String validUntil;
  String url;
  bool warranty;
  ReceiptModel(
    this.id,
    this.placeOfPurchase,
    this.items,
    this.totalPrice,
    this.cash,
    this.paid,
    this.tax,
    this.totalTaxValue,
    this.time,
    this.invoiceNumber,
    this.invoiceCounter,
    this.user,
    this.deleted,
    this.scanned,
    this.name,
    this.validUntil,
    this.url,
    this.warranty
  );
  static ReceiptModel fromJson(dynamic jsonObject){
    int id                =jsonObject["id"];
    double totalPrice     =jsonObject["receiptBody"]["totalPrice"];
    bool cash             =jsonObject["receiptBody"]["cash"] ?? false;
    double paid           =jsonObject["receiptBody"]["paid"];
    double tax            =jsonObject["tax"]??0;
    double totalTaxValue  =jsonObject["totalTaxValue"];
    String time           =jsonObject["sdc"]["time"];
    String invoiceNumber  =jsonObject["sdc"]["invoiceNumber"];
    String invoiceCounter =jsonObject["sdc"]["invoidceCounter"]??"neki invoice counter";
    bool deleted          =jsonObject["deleted"]??false;
    String scanned        =jsonObject["scanned"];
    String name           =jsonObject["name"]??"moj racun";
    String validUntil     =jsonObject["validUntil"]??"neki datum";
    String url            =jsonObject["url"];
    bool warranty         =jsonObject["warranty"];
    List<ArtikalModel> items=[];
    for(var a in jsonObject["receiptBody"]["items"]){
      items.add(ArtikalModel.fromJson(a));
    }
    UserModel user=UserModel.fromJson(jsonObject["user"]);
    PlaceOfPurchaseModel placeOfPurchase=PlaceOfPurchaseModel.fromJson(jsonObject["placeOfPurchase"]);
    return ReceiptModel(
      id,
      placeOfPurchase,
      items,
      totalPrice,
      cash,
      paid,
      tax,
      totalTaxValue,
      time,
      invoiceNumber,
      invoiceCounter,
      user,
      deleted,
      scanned,
      name,
      validUntil,
      url,
      warranty
    );
  }

  void printReceipt(){
    print("$name");
    for(ArtikalModel a in items){
      print(a.name);
    }
  }
}

List<ReceiptModel> receipts=[];