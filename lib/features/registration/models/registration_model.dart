// To parse this JSON data, do
//
//     final registrationResponseModel = registrationResponseModelFromJson(jsonString);

import 'dart:convert';

RegistrationResponseModel registrationResponseModelFromJson(String str) => RegistrationResponseModel.fromJson(json.decode(str));

String registrationResponseModelToJson(RegistrationResponseModel data) => json.encode(data.toJson());

/// Model class for registration response for parsing and utilizing further in app
class RegistrationResponseModel {
  String? customerId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  dynamic password;
  String? expertise;
  String? message;
  bool? status;
  int? statusCode;

  RegistrationResponseModel({
    this.customerId,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.password,
    this.expertise,
    this.message,
    this.status,
    this.statusCode,
  });

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) => RegistrationResponseModel(
    customerId: json["CustomerID"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    mobile: json["Mobile"],
    email: json["Email"],
    password: json["Password"],
    expertise: json["Expertise"],
    message: json["Message"],
    status: json["Status"],
    statusCode: json["StatusCode"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerID": customerId,
    "FirstName": firstName,
    "LastName": lastName,
    "Mobile": mobile,
    "Email": email,
    "Password": password,
    "Expertise": expertise,
    "Message": message,
    "Status": status,
    "StatusCode": statusCode,
  };
}
