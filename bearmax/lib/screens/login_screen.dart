import 'dart:convert';

import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/provider/auth_provider.dart';
import 'package:bearmax/model/login_model.dart';
import 'package:bearmax/screens/forgot_password.dart';
import 'package:bearmax/screens/home_screen.dart';
import 'package:bearmax/screens/signup_screen.dart';
import 'package:bearmax/screens/welcome_screen.dart';
import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 75),
              greeting(),
              const SizedBox(height: 20),
              SizedBox(
                width: 330,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    textField("Email", false),
                    const SizedBox(height: 16),
                    textField("Password", true),
                    forgotPassword()
                  ],
                ),
              ),
              const SizedBox(height: 60),
              loginButton(),
              const SizedBox(height: 10),
              signup()
            ],
          ),
        ),
      ),
    );
  }

  // Welcome
  Widget greeting() {
    return const Text("Welcome back",
        style: TextStyle(
            color: Palette.accentColorTwo, fontSize: 42, fontFamily: 'Roboto'));
  }

  // Email and password fields
  Widget textField(String hint, bool isPassword) {
    return TextFormField(
      controller: isPassword ? passwordController : usernameController,
      obscureText: isPassword ? hidePassword : false,
      decoration: InputDecoration(
          hintText: hint,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Palette.accentColor),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  color: Palette.accentColor,
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                )
              : null,
          prefixIcon:
              isPassword ? const Icon(Icons.lock) : const Icon(Icons.email)),
    );
  }

  // Forgot password
  Widget forgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen()),
              );
            },
            child: const Text(
              'Forgot your password?',
              style: TextStyle(
                color: Palette.accentColor,
                fontFamily: 'Roboto',
              ),
            ))
      ],
    );
  }

  // Login button
  Widget loginButton() {
    return ElevatedButton(
      onPressed: () {
        LoginRequest loginRequest = LoginRequest(
            email: usernameController.text, password: passwordController.text);
        ApiService apiService = ApiService();

        apiService.login(loginRequest).then((value) {
          if (value.statusCode == 200) {
            Map<String, dynamic> responseBody = json.decode(value.body);
            Provider.of<AuthProvider>(context, listen: false)
                .setAuthToken(responseBody['token']);
            Provider.of<AuthProvider>(context, listen: false)
                .setAuthID(responseBody['id']);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage(initialIndex: 1)),
            );

            if (kDebugMode) {
              print(responseBody['id']);
              print(responseBody['token']);
              print(responseBody['message']);
            }
          } else {
            const snackBar =
                SnackBar(content: Text('Incorrect Username or Password'));
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
        'LOGIN',
        style: TextStyle(
            color: Palette.backgroundColor, fontSize: 20, fontFamily: 'Roboto'),
      ),
    );
  }

  // No account button
  Widget signup() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Don't have an account?"),
      TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignupPage()),
          );
        },
        child: const Text(
          'Sign up here',
          style: TextStyle(color: Palette.accentColor),
        ),
      ),
    ]);
  }
}