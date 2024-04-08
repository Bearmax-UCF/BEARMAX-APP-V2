import 'dart:convert';

import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/screens/login_screen.dart';
import 'package:bearmax/util/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 75),
                      const Text("Forgot Password?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Palette.accentColorTwo,
                              fontSize: 38,
                              fontFamily: 'Roboto')),
                      const SizedBox(height: 20),
                      const Text(
                        "Enter the email associated with your account.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Palette.darkShadow,
                            fontSize: 16,
                            fontFamily: 'Roboto'),
                      ),
                      const SizedBox(height: 20),
                      emailTextEntry(),
                      const SizedBox(height: 60),
                      resetButton(),
                    ]))));
  }

  // Email text forrm
  Widget emailTextEntry() {
    return SizedBox(
      width: 330,
      child: Column(
        children: [
          const SizedBox(height: 40),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
                hintText: "Email",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Palette.accentColor),
                ),
                prefixIcon: Icon(Icons.email)),
          ),
          signupNavigator(),
        ],
      ),
    );
  }

  // Return to login screen
  Widget signupNavigator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text(
              'Back to Sign In',
              style: TextStyle(
                color: Palette.accentColor,
                fontFamily: 'Roboto',
              ),
            ))
      ],
    );
  }

  // Reset password button
  Widget resetButton() {
    return ElevatedButton(
      onPressed: () {
        if (kDebugMode) {
          print(emailController.text);
        }
        ApiService apiService = ApiService();
        apiService.forgotPassword(emailController.text).then((value) {
          Map<String, dynamic> responseBody = json.decode(value.body);
          if (kDebugMode) {
            print(value.statusCode);
          }
          if (value.statusCode == 201) {
            showResetPasswordDialog(context);
          } else {
            var snackBar = SnackBar(content: Text(responseBody['message']));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Palette.accentColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(const Size(300, 60)),
      ),
      child: const Text(
        'RESET PASSWORD',
        style: TextStyle(
            color: Palette.backgroundColor, fontSize: 20, fontFamily: 'Roboto'),
      ),
    );
  }

  // Reset widget
  void showResetPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Success"),
        content: const Text("Please check your email to reset your password."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
            },
            child: const Text("Okay", style: TextStyle(color: Palette.accentColor)),
          ),
        ],
      );
    },
  );
}
}
