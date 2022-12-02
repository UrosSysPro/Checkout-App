class ReceiptModel{
  final String prodavnica,adresa,code;
  final List<Artikal> artikli;
  ReceiptModel(this.prodavnica,this.adresa,this.code,this.artikli);
}

class Artikal{
  final String naziv;
  final double cena;
  final int kolicina;
  Artikal(this.naziv,this.cena,this.kolicina);
}

final List<ReceiptModel> receipts=[
  ReceiptModel("Maxi","VASE CARAPICA 9","www.google.com",
    [
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
    ]
  ),
  ReceiptModel("Maxi","VASE CARAPICA 9","www.google.com",
    [
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
    ]
  ),
  ReceiptModel("Maxi","VASE CARAPICA 9","www.google.com",
    [
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
    ]
  ),
  ReceiptModel("Maxi","VASE CARAPICA 9","www.google.com",
    [
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
    ]
  ),
  ReceiptModel("Maxi","VASE CARAPICA 9","www.google.com",
    [
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
    ]
  ),
  ReceiptModel("Maxi","VASE CARAPICA 9","www.google.com",
    [
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
      Artikal("Hleb",50,2),
      Artikal("Mleko",100,3),
    ]
  ),
];
