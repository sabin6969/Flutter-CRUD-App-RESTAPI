class ApiResponse {
  bool? sucess;
  String? message;

  ApiResponse({this.sucess, this.message});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    sucess = json["sucess"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["sucess"] = sucess;
    data["message"] = message;
    return data;
  }
}
