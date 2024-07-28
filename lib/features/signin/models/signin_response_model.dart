// To parse this JSON data, do
//
//     final signInResponseModel = signInResponseModelFromJson(jsonString);

import 'dart:convert';

SignInResponseModel signInResponseModelFromJson(String str) => SignInResponseModel.fromJson(json.decode(str));

String signInResponseModelToJson(SignInResponseModel data) => json.encode(data.toJson());

/// Model class for parsing the signIn response after making the api call
class SignInResponseModel {
  bool? status;
  String? message;
  int? statusCode;

  SignInResponseModel({
    this.status,
    this.message,
    this.statusCode,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) => SignInResponseModel(
    status: json["Status"],
    message: json["Message"],
    statusCode: json["StatusCode"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "StatusCode": statusCode,
  };
}
