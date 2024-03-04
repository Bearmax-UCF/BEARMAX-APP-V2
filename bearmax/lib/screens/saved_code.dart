// Saved code interact screen

/*
FutureBuilder(
                  future: ApiService.getUser(context),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No data available'));
                    } else {
                      final userData = json.decode(snapshot.data.body);
                      final firstName = userData['me']['firstName'];
                      return Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Hello, $firstName",
                              style: TextStyle(fontFamily: 'Roboto', fontSize: 40, color: Pallete.secondaryColor),
                            ),
                            // Your remaining widgets...
                          ],
                        ),
                      );
                    }
                  },
                ),
*/
/*
import 'dart:convert';

import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bearmax/api/api_service.dart';

class InteractScreen extends StatelessWidget {
  const InteractScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
   
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Pallete.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Hello, $", // USER
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 40, color: Pallete.secondaryColor),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    DateFormat.yMMMEd().format(DateTime.now()),
                    style: const TextStyle(fontFamily: 'Roboto', fontSize: 18, color: Pallete.secondaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 15,),
                      Container(
                        color: Colors.transparent,
                        height: 80,
                        width: 80,
                        child: Image.asset('assets/images/face.png', fit: BoxFit.cover,),
                      ),
                      const SizedBox(height: 45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Button 1 action
                            },
                             style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Pallete.accentColorTwo),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(const Size(120, 120)),
                            ),
                           
                            child: const Column(
                              children: [
                                SizedBox(height: 20),
                                Icon(Icons.emoji_emotions_outlined, color: Pallete.backgroundColor),
                                SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Emotion Game', 
                                  style: TextStyle(
                                  color: Pallete.backgroundColor,
                                  fontSize: 18,
                                  ),
                                ),
                              ]
                            )
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Button 2 action
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Pallete.accentColorTwo),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(Size(120, 120)),
                            ),
                            child: const Column(
                              children: [
                                SizedBox(height: 20),
                                Icon(Icons.favorite, color: Pallete.backgroundColor),
                                SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Stress Relief', 
                                  style: TextStyle(
                                  color: Pallete.backgroundColor,
                                  fontSize: 18,
                                  ),
                                ),
                              ]
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Button 4 action
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Pallete.accentColor),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(Size(270, 120)),
                            ),
                            child: const Column(
                              children: [
                                SizedBox(height: 30),
                                Icon(Icons.pause, color: Pallete.backgroundColor, size: 24),
                                SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Stop', 
                                  style: TextStyle(
                                  color: Pallete.backgroundColor,
                                  fontSize: 25,
                                  ),
                                ),
                              ]
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

*/


// SAVED CODE REGISTRATION SCREEN
/*
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
                : Container(), // Hidden when not logged in
          ],
        ),
      ),
    );
  }
}
*/

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








































// SAVED CODE LOGIN SCREEN
/*
//import 'package:flutter/cupertino.dart';
import 'package:bearmax/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bearmax/util/colors.dart';
//import 'package:bearmax/api/api_service.dart';
//import 'package:bearmax/model/login_model.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false;

  Future<void> loginUser() async {
    if (kDebugMode) {
      print("in future TESTING");
    }
    const  String apiUrl = "http://10.0.2.2:8080/api/auth/login";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "email": usernameController.text,
        "password": passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Login successful
      setState(() {
        isLoggedIn = true;
        Navigator.pushReplacement(
context,MaterialPageRoute(builder: (context) => const HomePage()),);
      });

      // TODO: Handle the token, navigate to the next screen, etc.
      Map<String, dynamic> data = json.decode(response.body);
      String token = data['token'];

      if (kDebugMode) {
        print("Login successful. Token: $token");
      }
    } else {
      // Login failed
      setState(() {
        isLoggedIn = false;
      });

      if (kDebugMode) {
        print("Login failed. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        print(usernameController.text);
        print(passwordController.text);
      }
    }
  }

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
                loginUser();
              },
              child: const Text('Login'),
            ),
            //const SizedBox(height: 16),

            

            /*
            isLoggedIn
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Pallete.accentColor,
                    child: Text(
                      'Welcome, ${usernameController.text}!',
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
*/
/*
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _image(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontFamily: 'Urbanist', fontSize: 42),
        ),
      ],
    );
  }

  _image(context) {
    return Column(children: [
      Image.asset('assets/images/waving_full.png'),
    ]);
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /*
        TextFormField(
          keyboardType: TextInputType.em,
          decoration: InputDecoration(
              hintText: "Email Address",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.grey.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
        ),
        */
        TextField(
          decoration: InputDecoration(
              hintText: "Email Address",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.grey.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF417154),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {},
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Color(0xFF417154)),
            ))
      ],
    );
  }
}
*/


/*

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel = LoginRequestModel(email: "", password: "");
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    loginRequestModel = LoginRequestModel(email: "", password: "");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Pallete.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: const EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: const Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 25),
                        const Text(
                          "Login",
                          style: TextStyle(fontFamily: 'Urbanist'),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => loginRequestModel.email = input!,
                          validator: (input) => !input!.contains('@')
                              ? "Email Id should be valid"
                              : null,
                           decoration: const InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Pallete.accentColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Pallete.accentColor)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Pallete.accentColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style:
                              const TextStyle(color: Pallete.accentColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              loginRequestModel.password = input!,
                          validator: (input) => input!.length < 3
                              ? "Password should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Pallete.primaryColor)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Pallete.accentColor)),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Pallete.accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Pallete.accentColor
                                  .withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () {
                            if (validateAndSave()) {
                              print(loginRequestModel.toJson());

                              setState(() {
                                isApiCallProcess = true;
                              });

                              APIService apiService = APIService();
                              apiService.login(loginRequestModel).then((value) {
                                if (value != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

                                  if (value.token.isNotEmpty) {
                                    const snackBar = SnackBar(
                                        content: Text("Login Successful"));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  } else {
                                    final snackBar =
                                        SnackBar(content: Text(value.error));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                }
                              });
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
*/

/*
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _image(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontFamily: 'Urbanist', fontSize: 42),
        ),
      ],
    );
  }

  _image(context) {
    return Column(children: [
      Image.asset('assets/images/waving_full.png'),
    ]);
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /*
        TextFormField(
          keyboardType: TextInputType.em,
          decoration: InputDecoration(
              hintText: "Email Address",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.grey.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
        ),
        */
        TextField(
          decoration: InputDecoration(
              hintText: "Email Address",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.grey.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF417154),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {},
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Color(0xFF417154)),
            ))
      ],
    );
  }
}
*/