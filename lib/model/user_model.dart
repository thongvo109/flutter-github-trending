class UserModel {
  String fullName;
  String email;
  String token;

  UserModel({
    this.fullName,
    this.email,
  });
  UserModel.fromJson(Map<String, dynamic> json)
      : fullName = json["fullName"],
        email = json["email"],
        token = json["token"];
}
