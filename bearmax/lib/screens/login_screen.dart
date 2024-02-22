import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/model/login_model.dart';
import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("in build");
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                
                LoginRequest loginRequest = LoginRequest(email: usernameController.text, password: passwordController.text);
                ApiService apiService = ApiService();

                apiService.login(loginRequest).then((value) {
                  if (value.statusCode == 200) {
                    const snackBar = SnackBar(content: Text("Login Successful"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    if(kDebugMode) {
                      print(value.body);
                    }
                  }
                  
                  else {
                    const snackBar = SnackBar(content: Text('Incorrect Username or Password'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },

              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}