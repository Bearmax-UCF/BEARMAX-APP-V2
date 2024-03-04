import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Your widget implementation
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Profile'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Pallete.black,
            ),
            onPressed: () {
              // Navigate to settings screen
            },
          )
        ],
      ),
      body:
          const Center(child: Text('Profile', style: TextStyle(fontSize: 60))),
    );
  }
}
