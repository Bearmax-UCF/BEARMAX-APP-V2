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
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 75),
            header(),
            const SizedBox(height: 35),
            SizedBox(
              width: 330,
              child: Column(
                children: [
                  textFormField("Email", emailController, Icons.email, false),
                  const SizedBox(height: 18),
                  textFormField(
                      "First Name", firstNameController, Icons.person, false),
                  const SizedBox(height: 20),
                  textFormField(
                      "Last Name", lastNameController, Icons.person, false),
                  const SizedBox(height: 18),
                  textFormField(
                      "Password", passwordController, Icons.lock, true),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            const SizedBox(height: 20),
            signupButton(),
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
            toLogin(),
          ],
        )),
      ),
    );
  }

  // Header text
  Widget header() {
    return const Text("Create account",
        style: TextStyle(
            color: Palette.accentColorTwo, fontSize: 42, fontFamily: 'Roboto'));
  }

  // Text form fields
  Widget textFormField(String text, TextEditingController controller,
      IconData icon, bool isPassword) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? hidePassword : false,
      decoration: InputDecoration(
          hintText: text,
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
          prefixIcon: Icon(icon)),
    );
  }

  // Press to signup
  Widget signupButton() {
    return ElevatedButton(
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
                content: Text('Another User with this email already exists!'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            const snackBar =
                SnackBar(content: Text('Missing one or more fields.'));
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
        'SIGN UP',
        style: TextStyle(
            color: Palette.backgroundColor, fontSize: 20, fontFamily: 'Roboto'),
      ),
    );
  }

  // Go to login screen if already has an account
  Widget toLogin() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    ]);
  }
}
