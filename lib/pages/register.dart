import 'dart:convert';

import 'package:cubbes_test_fe/components/passwordInput.dart';
import 'package:cubbes_test_fe/components/smallButton.dart';
import 'package:cubbes_test_fe/components/textInput.dart';
import 'package:cubbes_test_fe/components/titleText.dart';
import 'package:cubbes_test_fe/pages/home.dart';
import 'package:cubbes_test_fe/pages/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _otherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Future<void> _registerUser() async {
  //   String firstName = _firstNameController.text;
  //   String lastName = _lastNameController.text;
  //   String otherName = _otherNameController.text;
  //   String email = _emailController.text;
  //   String phoneNumber = _phoneNumberController.text;
  //   String password = _passwordController.text;
  //   String confirmPassword = _confirmPasswordController.text;

  //   if (firstName == "") {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('First Name is Required!'),
  //     ));
  //     return;
  //   }
  //   if (lastName == "") {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Last Name is Required!'),
  //     ));
  //     return;
  //   }
  //   if (email == "") {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Email is Required!'),
  //     ));
  //     return;
  //   }
  //   if (phoneNumber == "") {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Phone Number is Required!'),
  //     ));
  //     return;
  //   }
  //   if (password == "") {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Password is Required!'),
  //     ));
  //     return;
  //   }
  //   if (confirmPassword == "") {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Confirm Password is Required!'),
  //     ));
  //     return;
  //   }
  //   if (password != confirmPassword) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Password not Match!'),
  //     ));
  //     return;
  //   }

  //   setState(() {
  //     _processing = true;
  //   });

  //   try {
  //     // Your existing code
  //     final body = {
  //       "first_name": firstName,
  //       "last_name": firstName,
  //       "email": email,
  //       "phone_number": phoneNumber,
  //       "account_type": 'student',
  //       "password": password,
  //     };

  //     if (otherName.isNotEmpty) {
  //       body["other_name"] = otherName;
  //     }

  //     // Encode the body map to JSON
  //     String jsonBody = jsonEncode(body);

  //     var response = await http.post(
  //       Uri.parse('https://staging.mshelhomes.com/api/CRM/opportunities'),
  //       // Uri.parse('http://127.0.0.1:8000/api/auth/register'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonBody,
  //     );

  //     if (response.statusCode == 200) {
  //       final body = jsonDecode(response.body);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('We got signed in: ${body['message']}'),
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error: ${response.reasonPhrase}'),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: ${e}'),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Image.asset(
                'assets/images/Cubbes-Black.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 50),
              const TitleText(text: 'Register'),
              TextInput(
                controller: _firstNameController,
                labelText: 'First Name',
                icon: Icons.account_circle,
              ),
              TextInput(
                controller: _lastNameController,
                labelText: 'Last Name',
                icon: Icons.account_circle,
              ),
              TextInput(
                controller: _otherNameController,
                labelText: 'Other Name (Optional)',
                icon: Icons.account_circle,
              ),
              TextInput(
                controller: _emailController,
                labelText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              TextInput(
                controller: _phoneNumberController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
              ),
              PasswordInput(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.lock,
              ),
              PasswordInput(
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              SmallButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                text: "Sign Up",
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already a Member?',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
