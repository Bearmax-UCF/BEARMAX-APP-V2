import 'dart:convert';

import 'package:bearmax/model/new_note_model.dart';
import 'package:bearmax/provider/auth_provider.dart';
import 'package:bearmax/model/edit_profile_model.dart';
import 'package:bearmax/model/login_model.dart';
import 'package:bearmax/model/notes_model.dart';
import 'package:bearmax/model/signup_model.dart';
import 'package:bearmax/util/api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiService {
  Map<String, dynamic> data = {};

  // Login Api Call
  Future<http.Response> login(LoginRequest loginRequest) async {
    final response = await http.post(Uri.parse(ApiEndPoints.login),
        body: loginRequest.toJson());

    return response;
  }

  // Registration Api Call
  Future<http.Response> signup(SignupRequest signupRequest) async {
    final response = await http.post(Uri.parse(ApiEndPoints.register),
        body: signupRequest.toJson());

    return response;
  }

  // Get user call
  static Future<http.Response> getUser(BuildContext context) async {
    String authToken =
        Provider.of<AuthProvider>(context, listen: false).authToken;

    final response = await http.get(Uri.parse(ApiEndPoints.userInfo), headers: {
      'Authorization': 'Bearer $authToken',
    });

    return response;
  }

  // Edit user profile
  Future<http.Response> editUser(
      EditProfileRequest editProfileRequest, BuildContext context) async {
    String authToken =
        Provider.of<AuthProvider>(context, listen: false).authToken;
    String authID = Provider.of<AuthProvider>(context, listen: false).authID;

    String apiString = '${ApiEndPoints.editUser}/$authID';

    final response = await http.patch(
      Uri.parse(apiString),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: editProfileRequest.toJson(),
    );

    return response;
  }

  // Get list of notes
  Future<List<Note>> allNotes(BuildContext context) async {
    String authToken =
        Provider.of<AuthProvider>(context, listen: false).authToken;

    final response = await http.get(Uri.parse(ApiEndPoints.note), headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('GOT NOTES');
      }

      final List<dynamic> jsonData = json.decode(response.body)['allNotes'];
      return jsonData.map((data) => Note.fromJson(data)).toList();
    } else {
      throw Exception("Unauthorized. Could not retrieve notes.");
    }
  }

  // Add note
  Future<http.Response> addNote(NewNoteRequest noteRequest, BuildContext context) async {
    String authToken = Provider.of<AuthProvider>(context, listen: false).authToken;

    final response = await http.post(
      Uri.parse(ApiEndPoints.note),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: noteRequest.toJson()
    );

    return response;
  }
}
