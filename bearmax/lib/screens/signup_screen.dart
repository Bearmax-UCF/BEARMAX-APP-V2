import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bearmax/util/colors.dart';
import 'package:bearmax/screens/home_screen.dart';
import 'package:bearmax/screens/login_screen.dart';

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

  Future<void> signupUser() async {
    if(kDebugMode) {
      print("in future");
    }

    const String apiUrl = "http://10.0.2.2:8080/api/auth/register";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "email": emailController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "password": passwordController.text,
      },
    );

    if (response.statusCode == 201) {
      setState(() {
        isSignedUp = true;
        Navigator.pushReplacement(
context,MaterialPageRoute(builder: (context) => const LoginPage()),);
      });
    

   // Handle token, navigate to next screen, etc.
   Map<String, dynamic> data = json.decode(response.body);
   String token = data['token'];

   if (kDebugMode) {
    print("Registration successful. Token: $token");
   }
  }
   else {
    // registration failed
    setState(() {
      isSignedUp = false;
    });
   }

    if (kDebugMode) {
        print("Login failed. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("in build");
    }

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
                signupUser();
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
                : Container(), // Hidden when not logged in*/
          ],
        ),
      ),
    );
  }
}

/*
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.person)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.email)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Repeat Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Color(0xFF417154),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign in here.",
                          style: TextStyle(color: Color(0xFF417154)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/