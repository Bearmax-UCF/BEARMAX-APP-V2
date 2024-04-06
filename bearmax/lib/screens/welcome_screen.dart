import 'package:bearmax/screens/login_screen.dart';
import 'package:bearmax/screens/signup_screen.dart';
import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 150),
            logo(),
            const SizedBox(height: 130),
            button("Sign In", true, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }),
            const SizedBox(height: 10),
            button("Create Account", false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            })
          ],
        ),
      ),
    );
  }

  // Display logo
  Widget logo() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset('assets/images/bearmax-panda-face-title.png',
          width: 330, height: 330),
    ]);
  }

  // Sign in and create account buttons
  Widget button(String title, bool isSignIn, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            isSignIn ? Palette.backgroundColor : Palette.accentColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(const Size(300, 60)),
      ),
      child: Text(
        title,
        style: TextStyle(
            color: isSignIn ? Palette.accentColor : Palette.backgroundColor,
            fontSize: 20,
            fontFamily: 'Roboto'),
      ),
    );
  }
}
