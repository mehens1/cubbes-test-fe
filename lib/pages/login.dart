import 'dart:convert';

import 'package:cubbes_test_fe/components/pageLogo.dart';
import 'package:cubbes_test_fe/components/passwordInput.dart';
import 'package:cubbes_test_fe/components/smallButton.dart';
import 'package:cubbes_test_fe/components/textInput.dart';
import 'package:cubbes_test_fe/components/titleText.dart';
import 'package:cubbes_test_fe/pages/home.dart';
import 'package:cubbes_test_fe/pages/register.dart';
import 'package:cubbes_test_fe/utils/apiCalls.dart';
import 'package:cubbes_test_fe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key); // Corrected the key parameter

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeaderLogo(),
                const TitleText(text: 'Login'),
                TextInput(
                  controller: _usernameController,
                  labelText: 'Email or Phone Number',
                  icon: Icons.account_circle,
                ),
                PasswordInput(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                ),
                _isProcessing
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    : SmallButton(
                        onPressed: _login,
                        text: "Login",
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New Here?',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email or Phone Number is required!')),
      );
      return;
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password is required!')),
      );
      return;
    }

    setState(() {
      _isProcessing =
          true; // Set _isProcessing back to false when login process completes
    });

    try {
      final response = await login(username, password);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userToken', res['token']);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        // Failed login, show error message
        var res = jsonDecode(response.body);
        String message =
            res['message']; // Access the 'message' key from the decoded map
        showMessage(context, message);
      }
    } catch (e) {
      // Error occurred during login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }

    setState(() {
      _isProcessing = false;
    });
  }
}
