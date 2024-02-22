class SignupResponse {
  final String token;
  final String error;

  SignupResponse({required this.token, required this.error});

  factory SignupResponse.fromJson(Map<String, dynamic> json){
    return SignupResponse(
      token: json["token"] ?? "",
      error: json["error"] ?? "",
    );
  }
}

class SignupRequest {
  String email;
  String firstName;
  String lastName;
  String password;

  SignupRequest({required this.email, required this.firstName, required this.lastName, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'password': password.trim(),
    };

    return map;
  }
}