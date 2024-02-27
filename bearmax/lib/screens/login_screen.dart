import 'dart:convert';

import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/api/auth_provider.dart';
import 'package:bearmax/model/login_model.dart';
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
          icon: const Icon(Icons.arrow_back), // Your icon here
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            ); // Switch back to title screen -- Make title screen
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
              const Text("Welcome back",
                  style: TextStyle(
                      color: Pallete.accentColorTwo,
                      fontSize: 42,
                      fontFamily: 'Roboto')),
              const SizedBox(height: 20),
              SizedBox(
                width: 330,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          hintText: "Email",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .grey, // Adjust the color for unfocused state
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Pallete.accentColor),
                          ),
                          prefixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .grey, // Adjust the color for unfocused state
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Pallete.accentColor),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            color: Pallete.accentColor,
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          prefixIcon: const Icon(Icons.lock)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot your password?',
                              style: TextStyle(
                                color: Pallete.accentColor,
                                fontFamily: 'Roboto',
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  LoginRequest loginRequest = LoginRequest(
                      email: usernameController.text,
                      password: passwordController.text);
                  ApiService apiService = ApiService();

                  apiService.login(loginRequest).then((value) {
                    if (value.statusCode == 200) {
                      Map<String, dynamic> responseBody =
                          json.decode(value.body);
                      Provider.of<AuthProvider>(context, listen: false).setAuthToken(responseBody['token']);
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()),
                    );
                      /*
                      const snackBar =
                          SnackBar(content: Text("Login Successful"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);*/

                      if (kDebugMode) {
                        print(responseBody['id']);
                        print(responseBody['token']);
                        print(responseBody['message']);
                      }
                    } else {
                      const snackBar = SnackBar(
                          content: Text('Incorrect Username or Password'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Pallete.accentColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30.0), 
                    ),
                  ),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(300, 60)),
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Pallete.backgroundColor,
                      fontSize: 20,
                      fontFamily: 'Roboto'),
                ),
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text(
                    'Sign up here',
                    style: TextStyle(color: Pallete.accentColor),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
