import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/model/signup_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Pallete.accentColor, fontSize: 42, fontFamily: 'Urbanist'),

        actions: <Widget> [

          IconButton(
            
           
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
             onPressed: () {
              
          },
          
          )
          
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First name'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: "Last name"),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password", icon: Icon(Icons.password)),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () {
                SignupRequest signupRequest = SignupRequest(email: emailController.text, firstName: firstNameController.text, lastName: lastNameController.text, password: passwordController.text);
                ApiService apiService = ApiService();
                apiService.signup(signupRequest).then((value) {
                  if (value.statusCode == 201) {
                    const snackBar = SnackBar(content: Text("Successfully Created Account"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  else if (value.statusCode == 422) {
                    const snackBar = SnackBar(content: Text('Another User with this email already exists!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  
                  else {
                    const snackBar = SnackBar(content: Text('Missing one or more fields.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              child: const Text('Sign Up'),
            ),

            isSignedUp
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Pallete.accentColor,
                    child: Text(
                      'Welcome, ${firstNameController.text}!',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                : Container(), 
          ],
        ),
      ),
    );
  }
}

