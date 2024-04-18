class LoginResponse {
  final String token;
  final String id;
  final String message;

  LoginResponse({required this.token, required this.id, required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json["token"] ?? "",
      id: json["id"] ?? "",
      message: json["message"] ?? "",
    );
  }
}

class LoginRequest {
  String email;
  String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
