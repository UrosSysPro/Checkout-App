
class ArtikalModel{
  int id;
  String name;
  double price,quantity,total;
  bool weighted;
  String product;

  ArtikalModel(
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.weighted,
    this.total,
    this.product
  );
  static ArtikalModel fromJson(dynamic a){
    int id=a["id"];
    String name=a["name"];
    double price=a["price"],quantity=a["quantity"],total=a["total"];
    bool weighted=a["weighted"];
    String product=a["product"]??"Hleb";
    return ArtikalModel(id,name,price,quantity,weighted,total,product);
  }
}