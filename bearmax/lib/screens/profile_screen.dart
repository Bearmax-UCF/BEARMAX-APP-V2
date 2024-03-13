import 'dart:convert';
import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/screens/edit_profile_screen.dart';
import 'package:bearmax/screens/welcome_screen.dart';
import 'package:bearmax/util/colors.dart';
import 'package:bearmax/widgets/profile_picture_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Profile'),
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
              FutureBuilder(
                future: ApiService.getUser(context),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final userData = json.decode(snapshot.data.body);
                    final firstName = userData['me']['firstName'];
                    final lastName = userData['me']['lastName'];
                    final fullName = '$firstName $lastName';
                    return Column(
                      children: <Widget>[
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            color: Palette.black,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              FutureBuilder(
                future: ApiService.getUser(context),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final userData = json.decode(snapshot.data.body);

                    return Column(
                      children: <Widget>[
                        Text(
                          userData['me']['email'],
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: Palette.accentColor,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 45),
              const Divider(
                color: Palette.grey,
                thickness: 2,
                indent: 35,
                endIndent: 35,
              ),
              //const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(120, 90),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.edit, color: Palette.black),
                          SizedBox(width: 10),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Palette.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Palette.black, size: 16),
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  // media
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(120, 90),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.music_note, color: Palette.black),
                          SizedBox(width: 10),
                          Text(
                            'My Media',
                            style: TextStyle(
                              color: Palette.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Palette.black, size: 16),
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  // Button 2 action
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(120, 90),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.settings, color: Palette.black),
                          SizedBox(width: 10),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: Palette.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Palette.black, size: 16),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  logoutAlert(context);
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(120, 90),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.logout, color: Palette.red),
                          SizedBox(width: 10),
                          Text(
                            'Log Out',
                            style: TextStyle(
                              color: Palette.red,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Palette.red, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logoutAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Are you sure you want to log out?"),
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
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()),
                );
              },
              child: const Text('OK', style: TextStyle(color: Palette.blue)),
            ),
          ],
        );
      },
    );
  }
}
