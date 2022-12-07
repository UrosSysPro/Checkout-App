class UserModel{
  int id;
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
    int id=int.parse(u["id"]);
    String created=u["created"];
    String password=u["password"];
    String birthDate=u["dirthDate"]??"neki datum";
    String ethnicity=u["ethnicity"]??"neki etnisiti";
    String nationality=u["nationality"];
    String maritalStatus=u["maritalStatus"];
    double salary=0;
    bool male=u["male"];
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