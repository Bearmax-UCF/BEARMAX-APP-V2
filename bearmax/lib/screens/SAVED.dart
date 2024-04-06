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
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/images/bearmax-panda-face-title.png',
                  width: 330, height: 330),
            ]),
            const SizedBox(height: 130),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Palette.backgroundColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(const Size(300, 60)),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                    color: Palette.accentColor,
                    fontSize: 20,
                    fontFamily: 'Roboto'),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Palette.accentColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(const Size(300, 60)),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(
                    color: Palette.backgroundColor,
                    fontSize: 20,
                    fontFamily: 'Roboto'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
