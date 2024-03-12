import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _authToken = '';
  String get authToken => _authToken;

  String _authID= '';
  String get authID => _authID;

  Future<void> setAuthID(String id) async {
    _authID = id;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authID', id);
  }

  Future<void> loadAuthID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _authID = prefs.getString('authID') ?? '';
    notifyListeners();
  }


  Future<void> setAuthToken(String token) async {
    _authToken = token;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<void> loadAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('authToken') ?? '';
    notifyListeners();
  }
}
