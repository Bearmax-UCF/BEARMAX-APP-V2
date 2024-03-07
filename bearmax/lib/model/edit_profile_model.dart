class EditProfileResponse {
  final String userID;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool isVerified;
  final List<String> oldPassswords;
  final String hashToken;
  final int version;

  EditProfileResponse(
      {required this.userID,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.isVerified,
      required this.oldPassswords,
      required this.hashToken,
      required this.version});

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(
        userID: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        isVerified: json["isVerified"],
        oldPassswords: json["oldPasswords"],
        hashToken: json["hashToken"],
        version: json["__v"]);
  }
}

class EditProfileRequest {
  String? email;
  String? password;
  String? firstName;
  String? lastName;

  EditProfileRequest(
      {this.email, this.password, this.firstName, this.lastName});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email?.trim(),
      'password': password?.trim(),
      'lastName': lastName?.trim(),
      'firstName': firstName?.trim(),
    };

    return map;
  }
}
