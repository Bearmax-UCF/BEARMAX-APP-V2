class GetUserResponse {
  final String userID;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool isVerified;
  final List<String> oldPassswords;
  final String hashToken;
  final int version;

  GetUserResponse({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.isVerified,
    required this.oldPassswords,
    required this.hashToken,
    required this.version
  });

  factory GetUserResponse.fromJson(Map<String, dynamic> json) {
    return GetUserResponse(
      userID: json["_id"], 
      firstName: json["firstName"], 
      lastName: json["lastName"], 
      email: json["email"], 
      password: json["password"], 
      isVerified: json["isVerified"], 
      oldPassswords: json["oldPasswords"], 
      hashToken: json["hashToken"], 
      version: json["__v"]
    );
  }
}