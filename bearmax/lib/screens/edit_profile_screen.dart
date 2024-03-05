import 'dart:convert';
import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/screens/edit_profile_screen.dart';
import 'package:bearmax/util/colors.dart';
import 'package:bearmax/widgets/profile_picture_widget.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              ProfilePicture(
                image: 'assets/images/pfp.png',
                onClicked: () async {},
              ),
              const SizedBox(height: 10),
              
             
              
            ],
          ),
        ),
      ),
    );
  }
}
