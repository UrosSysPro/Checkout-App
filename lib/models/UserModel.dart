class UserModel{
  String id;
  String created;
  String password;
  String birthDate;
  String ethnicity;
  String nationality;
  String maritalStatus;
  double salary;
  bool male;

  UserModel(
    this.id,
    this.created,
    this.password,
    this.birthDate,
    this.ethnicity,
    this.nationality,
    this.maritalStatus,
    this.salary,
    this.male
  );
  static UserModel fromJson(dynamic u){
    String id=u["id"]??"nemmaaaaa";
    String created=u["created"]??"neammmaa";
    String password=u["password"]??"ne postoji password";
    String birthDate=u["dirthDate"]??"neki datum";
    String ethnicity=u["ethnicity"]??"neki etnisiti";
    String nationality=u["nationality"]??"ne postoji nationality";
    String maritalStatus=u["maritalStatus"]??"nema";
    double salary=0;
    bool male=u["male"]??true;
    return UserModel(
      id,
      created,
      password,
      birthDate,
      ethnicity,
      nationality,
      maritalStatus,
      salary,
      male
    );
  }
}