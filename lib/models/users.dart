class Users {
  int? userId;
  String? userName;
  int? userAge;

  Users({this.userId, this.userName, this.userAge});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    userName = json["userName"];
    userAge = json["userAge"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;
    data["userName"] = userName;
    data["userAge"] = userAge;
    return data;
  }
}
