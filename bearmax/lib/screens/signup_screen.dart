import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/model/signup_model.dart';
import 'package:bearmax/screens/login_screen.dart';
import 'package:bearmax/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:bearmax/util/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isSignedUp = false;
  bool hidePassword = false;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 75),
            const Text("Create account",
                style: TextStyle(
                    color: Palette.accentColorTwo,
                    fontSize: 42,
                    fontFamily: 'Roboto')),
            const SizedBox(height: 35),
            SizedBox(
              width: 330,
              child: Column(
                children: [
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
                          borderSide:
                              BorderSide(width: 2, color: Palette.accentColor),
                        ),
                        prefixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                        hintText: "First Name",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Palette.accentColor),
                        ),
                        prefixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                        hintText: "Last Name",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Palette.accentColor),
                        ),
                        prefixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        hintText: "Password",
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Palette.accentColor),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          color: Palette.accentColor,
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        prefixIcon: const Icon(Icons.lock)),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                SignupRequest signupRequest = SignupRequest(
                    email: emailController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    password: passwordController.text);
                ApiService apiService = ApiService();
                apiService.signup(signupRequest).then((value) {
                  if (value.statusCode == 201) {
                    const snackBar =
                        SnackBar(content: Text("Successfully Created Account"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (value.statusCode == 422) {
                    const snackBar = SnackBar(
                        content: Text(
                            'Another User with this email already exists!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    const snackBar =
                        SnackBar(content: Text('Missing one or more fields.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Palette.accentColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30.0), // Adjust the value to change the roundness
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(const Size(300, 60)),
              ),
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                    color: Palette.backgroundColor,
                    fontSize: 20,
                    fontFamily: 'Roboto'),
              ),
            ),
            isSignedUp
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Palette.accentColor,
                    child: Text(
                      'Welcome, ${firstNameController.text}!',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                : Container(),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Login here',
                  style: TextStyle(color: Palette.accentColor),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
