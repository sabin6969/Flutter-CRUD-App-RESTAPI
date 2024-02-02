class User {
  int? userId;
  String? userName;
  int? userAge;

  User({this.userId, this.userName, this.userAge});

  User.fromJson(Map<String, dynamic> json) {
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
