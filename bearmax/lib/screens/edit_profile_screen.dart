import 'dart:convert';
import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/model/edit_profile_model.dart';
import 'package:bearmax/util/colors.dart';
import 'package:bearmax/widgets/profile_picture_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 5, bottom: 5),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                ProfilePicture(
                  image: 'assets/images/bearmax-panda-full-no-title.png',
                  onClicked: () async {},
                ),
                const SizedBox(height: 15),
                textForm("First Name", "firstName", firstNameController, false),
                const SizedBox(height: 20),
                textForm("Last Name", "lastName", lastNameController, false),
                const SizedBox(height: 20),
                textForm("Email", "email", emailController, false),
                const SizedBox(height: 20),
                textForm("Password", "password", passwordController, true),
                const SizedBox(height: 20),
                submit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget submit() {
    return ElevatedButton(
        onPressed: () {
          EditProfileRequest editProfileRequest = EditProfileRequest(
              email: emailController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              password: passwordController.text);
          ApiService apiService = ApiService();
          apiService.editUser(editProfileRequest, context).then((value) {
            
            Map<String, dynamic> responseBody = json.decode(value.body);

          
            if (value.statusCode == 200) {
              const snackBar = SnackBar(content: Text("Successfully Changed"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              var snackBar = SnackBar(content: Text(responseBody['message']));
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
          fixedSize: MaterialStateProperty.all<Size>(const Size(290, 50)),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
              color: Palette.backgroundColor,
              fontSize: 20,
              fontFamily: 'Roboto'),
        ));
  }

  Widget textForm(
      String label, String data, TextEditingController tec, bool isPass) {
    return FutureBuilder(
      future: ApiService.getUser(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          final userData = json.decode(snapshot.data.body);
          final newData = userData['me'][data];

          if (kDebugMode) {
            print(newData);
          }

          if (!isPass) {
            return textField(label, newData, tec);
          } else {
            return passwordField();
          }
        }
      },
    );
  }

  Widget passwordField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Password",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(height: 8),
      SizedBox(
         
        height: 50,
        child:
      TextFormField(
        obscureText: showPassword,
        controller: passwordController,
        
        decoration: InputDecoration(
          labelText: "Enter new password",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Palette.accentColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            color: Palette.accentColor,
            icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
          ),
          isDense: true,
        ),
      )
    ),
    ]);
  }

  Widget textField(
      String label, String hint, TextEditingController controller) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(height: 8),

      SizedBox(height: 50,
        child:
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint.toString(),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Palette.accentColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          isDense: true,
        ),
      )),
    ]);
  }
}
