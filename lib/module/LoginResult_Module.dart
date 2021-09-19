// To parse this JSON data, do
//
//     final loginResult = loginResultFromJson(jsonString);

import 'dart:convert';

LoginResult loginResultFromJson(String str) => LoginResult.fromJson(json.decode(str));

String loginResultToJson(LoginResult data) => json.encode(data.toJson());

class LoginResult {
  LoginResult({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  int status;
  bool success;
  String message;
  Data data;

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.email,
    this.userId,
  });

  String email;
  String userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "userId": userId,
  };
}
