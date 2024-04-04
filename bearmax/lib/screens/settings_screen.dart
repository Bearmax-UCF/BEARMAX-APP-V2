import 'dart:convert';

import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/screens/welcome_screen.dart';
import 'package:bearmax/util/colors.dart';
import 'package:bearmax/widgets/settings_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings',
            style:
                TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto')),
        shape: const Border(bottom: BorderSide(color: Palette.grey, width: 1)),
        elevation: 4,
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SettingsItem(
                  label: 'Delete Account',
                  labelColor: Palette.red,
                  icon: Icons.delete_forever,
                  iconColor: Palette.red,
                  onTap: () {
                    deleteAlert(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "Are you sure you want to delete your account? This action cannot be undone."),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel', style: TextStyle(color: Palette.red)),
            ),
            TextButton(
              onPressed: () {
                ApiService apiService = ApiService();
                apiService.deleteUser(context).then((value) {
                  Map<String, dynamic> responseBody = json.decode(value.body);

                  if (value.statusCode == 200) {
                    if (kDebugMode) {
                      print(responseBody['user']);
                    }

                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                    );
                  } else {
                    var snackBar = const SnackBar(
                        content: Text('Could not delete account.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              child: const Text('OK', style: TextStyle(color: Palette.blue)),
            ),
          ],
        );
      },
    );
  }
}
