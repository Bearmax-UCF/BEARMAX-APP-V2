import 'package:bearmax/model/login_model.dart';
import 'package:bearmax/model/signup_model.dart';
import 'package:bearmax/util/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Map<String, dynamic> data = {};
  
  // Login Api Call
  Future<http.Response> login(LoginRequest loginRequest) async {
    
    final response = await http.post(
      Uri.parse(ApiEndPoints.login),
      body: loginRequest.toJson()
    );

    return response;
  }

  Future<http.Response> signup(SignupRequest signupRequest) async {
    final response = await http.post(
      Uri.parse(ApiEndPoints.register),
      body: signupRequest.toJson()
    );

    return response;
  }
}