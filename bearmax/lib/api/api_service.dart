import 'dart:convert';
import 'dart:io';

import 'package:bearmax/model/new_note_model.dart';
import 'package:bearmax/model/user_files_model.dart';
import 'package:bearmax/provider/auth_provider.dart';
import 'package:bearmax/model/edit_profile_model.dart';
import 'package:bearmax/model/login_model.dart';
import 'package:bearmax/model/notes_model.dart';
import 'package:bearmax/model/signup_model.dart';
import 'package:bearmax/util/api_endpoints.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
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

  // Forgot Password Api Call
  Future<http.Response> forgotPassword(String email) async {
    final response = await http.post(Uri.parse(ApiEndPoints.forgotPassword),
    body: {'email': email});

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

    String apiString = '${ApiEndPoints.editUser}$authID';

    final response = await http.patch(
      Uri.parse(apiString),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: editProfileRequest.toJson(),
    );

    return response;
  }

  // Delete user profile
  Future<http.Response> deleteUser(BuildContext context) async {
    String authToken =
        Provider.of<AuthProvider>(context, listen: false).authToken;
    String authID = Provider.of<AuthProvider>(context, listen: false).authID;

    String apiString = '${ApiEndPoints.editUser}$authID';

    final response = await http.delete(Uri.parse(apiString),
        headers: {'Authorization': 'Bearer $authToken'});

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
  Future<http.Response> addNote(
      NewNoteRequest noteRequest, BuildContext context) async {
    String authToken =
        Provider.of<AuthProvider>(context, listen: false).authToken;

    final response = await http.post(Uri.parse(ApiEndPoints.note),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: noteRequest.toJson());

    return response;
  }

  // Delete note
  Future<http.Response> deleteNote(BuildContext context, String noteid) async {
    String authToken =
        Provider.of<AuthProvider>(context, listen: false).authToken;

    final response =
        await http.delete(Uri.parse('${ApiEndPoints.note}/$noteid'), headers: {
      'Authorization': 'Bearer $authToken',
    });

    return response;
  }

  // Edit note
  Future<http.Response> editNote(EditNoteRequest editNoteRequest,
      BuildContext context, String noteid) async {
    String authToken =
        Provider.of<AuthProvider>(context, listen: false).authToken;

    final response = await http.patch(Uri.parse('${ApiEndPoints.note}/$noteid'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: editNoteRequest.toJson());

    return response;
  }

  // Add file
  Future<http.StreamedResponse> addFile(BuildContext context, FilePickerResult fpr) async {
    String authToken = Provider.of<AuthProvider>(context, listen: false).authToken;
    String authID = Provider.of<AuthProvider>(context, listen: false).authID;

    PlatformFile file = fpr.files.first;
    String apiString;

    final filepath = file.path;
    final mimeType = lookupMimeType(filepath!);
    String filePath = filepath.toString();

    if (mimeType == "audio/mpeg") 
    {
      apiString = '${ApiEndPoints.uploadAudio}$authID';
    } 
    else if (mimeType == "video/mp4") 
    {
      apiString = '${ApiEndPoints.uploadVideo}$authID';
    } 
    else 
    {
      throw Exception("exception: $mimeType");
    }

    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-type': mimeType ?? 'application/octet-stream',
    };
    var request = http.MultipartRequest('POST', Uri.parse(apiString));
    request.files.add(
      http.MultipartFile(
        'file', 
        File(filePath).readAsBytes().asStream(), 
        file.size,
        filename: file.name, 
        contentType: MediaType.parse(
            mimeType ?? 'application/octet-stream'), 
      ),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;
  }

  // Get all files
  Future<List<FileBlob>> allFiles(BuildContext context) async {
    String authToken =
        Provider.of<AuthProvider>(context, listen: false).authToken;
    String authID = Provider.of<AuthProvider>(context, listen: false).authID;
    String apiString = '${ApiEndPoints.getAllFiles}$authID';

    final response = await http.get(Uri.parse(apiString), headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['blobsList'];
      return jsonData.map((data) => FileBlob.fromJson(data)).toList();
    } else {
      throw Exception("${response.statusCode}: ${response.body}");
    }
  }
}
