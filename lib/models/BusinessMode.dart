class BusinessModel{
  int id,tin;
  String name;
  String logo;
  BusinessModel(this.id,this.name,this.logo,this.tin);

  static BusinessModel fromJson(dynamic b){
    int id=b["id"];
    int tin=b["tin"];
    String name=b["name"];
    String logo=b["logo"]??"";
    return BusinessModel(id,name,logo,tin);
  }
}