class SignupResponse {
  final String message;
  

  SignupResponse({required this.message});

  factory SignupResponse.fromJson(Map<String, dynamic> json){
    return SignupResponse(
      message: json["message"] ?? "",
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