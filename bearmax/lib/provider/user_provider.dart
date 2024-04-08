import 'dart:convert';

import 'package:bearmax/api/api_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;

  UserProvider(BuildContext context) {
    getUserAndUpdateState(context);
  }

  // Initialize with data from getUser();
  Future<void> getUserAndUpdateState(BuildContext context) async {
    try {
      final response = await ApiService.getUser(context);
      final userData = json.decode(response.body);

      final firstName = userData['me']['firstName'];
      final lastName = userData['me']['lastName'];
      final email = userData['me']['email'];

      _firstName = firstName;
      _lastName = lastName;
      _email = email;
      notifyListeners();
    } catch (error) {
      _firstName = '';
      _lastName = '';
      _email = '';
    }
  }

  void updateFirstName(String name) {
    _firstName = name;
    notifyListeners();
  }

  void updateLastName(String name) {
    _lastName = name;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }
}
