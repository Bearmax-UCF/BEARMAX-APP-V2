import 'package:bearmax/api/auth_provider.dart';
import 'package:bearmax/model/login_model.dart';
import 'package:bearmax/model/signup_model.dart';
import 'package:bearmax/util/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

  // Registration Api Call
  Future<http.Response> signup(SignupRequest signupRequest) async {
    final response = await http.post(
      Uri.parse(ApiEndPoints.register),
      body: signupRequest.toJson()
    );

    return response;
  }

  // Get user call
  static Future<http.Response> getUser(BuildContext context) async {
    String authToken = Provider.of<AuthProvider>(context, listen: false).authToken;

    final response = await http.get(
      Uri.parse(ApiEndPoints.userInfo),
      headers: {
        'Authorization': 'Bearer $authToken',
      }
    );

    return response;
  }
}