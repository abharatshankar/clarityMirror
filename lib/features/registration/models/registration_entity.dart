/// Entity class for passing to the registration api
class RegistrationEntity {
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? password;
  String? expertise;

  RegistrationEntity({
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.password,
    this.expertise,
  });

  factory RegistrationEntity.fromJson(Map<String, dynamic> json) => RegistrationEntity(
    firstName: json["FirstName"],
    lastName: json["LastName"],
    mobile: json["Mobile"],
    email: json["Email"],
    password: json["Password"],
    expertise: json["Expertise"],
  );

  Map<String, dynamic> toJson() => {
    "FirstName": firstName,
    "LastName": lastName,
    "Mobile": mobile,
    "Email": email,
    "Password": password,
    "Expertise": expertise,
  };
}
