import 'package:check_out_app/models/BusinessMode.dart';

class PlaceOfPurchaseModel{
  int id;
  BusinessModel business;
  String name,adress,place;
  int cashier;
  String posnumber;
  PlaceOfPurchaseModel(
    this.id,
    this.business,
    this.name,
    this.adress,
    this.place,
    this.cashier,
    this.posnumber
  );

  static PlaceOfPurchaseModel fromJson(dynamic p){
    int id          =p["id"];
    BusinessModel business=BusinessModel.fromJson(p["business"]);
    String name     =p["name"];
    String adress   =p["adress"]??"neka adresa";
    String place    =p["place"];
    int cashier     =p["cashier"]??1;
    String posnumber=p["posnumber"];
    return PlaceOfPurchaseModel(
      id,
      business,
      name,
      adress,
      place,
      cashier,
      posnumber
    );
  }
}