import 'package:bearmax/provider/user_provider.dart';
import 'package:bearmax/screens/edit_profile_screen.dart';
import 'package:bearmax/screens/settings_screen.dart';
import 'package:bearmax/screens/user_media.dart';
import 'package:bearmax/screens/welcome_screen.dart';
import 'package:bearmax/util/colors.dart';
import 'package:bearmax/widgets/profile_picture_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
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
                image: 'assets/images/bearmax-panda-full-no-title.png',
                onClicked: () async {},
              ),
              const SizedBox(height: 10),
              nameDisplay(context),
              emailDisplay(context),
              const SizedBox(height: 45),
              const Divider(
                color: Palette.grey,
                thickness: 2,
                indent: 35,
                endIndent: 35,
              ),
              button("Edit Profile", false, Icons.edit, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfileScreen()),
                );
              }),
              button("My Media", false, Icons.music_note, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserMediaScreen()),
                );
              }),
              button("Settings", false, Icons.settings, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              }),
              button("Log out", true, Icons.logout, () {
                logoutAlert(context);
              })
            ],
          ),
        ),
      ),
    );
  }

  // Display full name
  Widget nameDisplay(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        final firstName = userProvider.firstName;
        final lastName = userProvider.lastName;

         return Column(
            children: <Widget>[
              Text(
                '$firstName $lastName',
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Palette.black,
                ),
              ),
            ],
          );
      },
    );
  }
  
  // Display email
  Widget emailDisplay(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        final email = userProvider.email;

         return Column(
            children: <Widget>[
              Text(
                email,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Palette.accentColor,
                ),
              ),
            ],
          );
      },
    );
  }
  
  // Profile screen navigation buttons
  Widget button(
      String title, bool isLogout, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
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
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: isLogout ? Palette.red : Palette.black),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: isLogout ? Palette.red : Palette.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios,
                color: isLogout ? Palette.red : Palette.black, size: 16),
          ],
        ),
      ),
    );
  }

  // Logout popup
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
