import 'dart:convert';

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
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

import 'package:http_parser/http_parser.dart';

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
  /*
  Future<void> addFile(BuildContext context, FilePickerResult fpr) async {
    String authToken = Provider.of<AuthProvider>(context, listen: false).authToken;
    String authID = Provider.of<AuthProvider>(context, listen: false).authID;

    PlatformFile file = fpr.files.first;
    String apiString;

    final filepath = file.path;
    final mimeType = lookupMimeType(filepath!);

    if (kDebugMode) {
      print('MIME type: $mimeType');
      print(file);
    }

    if (mimeType == "audio/mpeg") {
      if(kDebugMode) {
        print("audio");
      }
      apiString = '${ApiEndPoints.uploadAudio}$authID';
    }
    else if (mimeType == "video/mp4") {
      if(kDebugMode) {
        print("video");
      }
      apiString = '${ApiEndPoints.uploadVideo}$authID';
    }
    else {
      //apiString = '${ApiEndPoints.uploadVideo}$authID';
      throw Exception("exception: $mimeType");
    }

    String filePath = filepath.toString();
    if(kDebugMode) {
      print(filepath);
    }
    var headers = {'Authorization': 'Bearer $authToken'};
    var request = http.MultipartRequest('POST', Uri.parse(apiString));
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    

    // Read the stream and convert it into a string
  String responseBody = await response.stream.bytesToString();

  // Print the response body
  if (kDebugMode) {
    print(responseBody);
  }

  if (kDebugMode) {
      print('AFTER MIME type: $mimeType');
      print(file);
    }

    
    //List<int> bytes = await response.stream.toBytes();

    // Create a Response object from the byte array and other response information
    //http.Response r = http.Response.bytes(bytes, response.statusCode,
        //headers: response.headers);

   

    //return r;
  }*/

  // Get file
  /*
  Future<void> addFile(BuildContext context, FilePickerResult result) async {
    String authToken = Provider.of<AuthProvider>(context, listen: false).authToken;
    String authID = Provider.of<AuthProvider>(context, listen: false).authID;

    final file = result.files.first;
    final filePath = file.path;
    final mimeType = filePath != null ? lookupMimeType(filePath) : null;
    final contentType = mimeType != null ? MediaType.parse(mimeType) : null;

    final fileReadStream = file.readStream;
    if (fileReadStream == null) {
      throw Exception('Cannot read file from null stream');
    }

    final stream = http.ByteStream(fileReadStream);

    String url;

    if (mimeType == "audio/mpeg") {
      if(kDebugMode) {
        print("audio");
      }
      url = '${ApiEndPoints.uploadAudio}$authID';
    }
    else if (mimeType == "video/mp4") {
      if(kDebugMode) {
        print("video");
      }
      url = '${ApiEndPoints.uploadVideo}$authID';
    }
    else {
      throw Exception("exception: $mimeType");
    }

    final headers = {'Authorization': 'Bearer $authToken'};
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final multipartFile = http.MultipartFile(
      'file',
      stream,
      file.size,
      filename: file.name,
      contentType: contentType,
    );
    request.files.add(multipartFile);
    request.headers.addAll(headers);

    final httpClient = http.Client();
    final response = await httpClient.send(request);

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final body = await response.stream.transform(utf8.decoder).join();

    if (kDebugMode) {
      print(body);
    }

  }*/


  // Get all files
  Future<List<FileBlob>> allFiles(BuildContext context) async {
    String authToken = Provider.of<AuthProvider>(context, listen: false).authToken;
    String authID = Provider.of<AuthProvider>(context, listen: false).authID;
    String apiString = '${ApiEndPoints.getAllFiles}$authID';

    final response = await http.get(
      Uri.parse(apiString), 
      headers: {
      'Authorization': 'Bearer $authToken',
    });

    if(kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }


    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('GOT ALL FILES');
      }

      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => FileBlob.fromJson(data)).toList();
    } else {
      throw Exception("${response.statusCode}: ${response.body}");
    }
  }

}
