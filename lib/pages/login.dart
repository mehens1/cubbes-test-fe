import 'package:cubbes_test_fe/components/passwordInput.dart';
import 'package:cubbes_test_fe/components/smallButton.dart';
import 'package:cubbes_test_fe/components/textInput.dart';
import 'package:cubbes_test_fe/components/titleText.dart';
import 'package:cubbes_test_fe/pages/home.dart';
import 'package:cubbes_test_fe/pages/register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/Cubbes-Black.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            const Spacer(),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: SmallButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                text: "Login",
              ),
            ),
            // const Spacer(),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  void login() async {
    // Fluttertoast.showToast(msg: "we are fine sir");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('we are fine sir'),
    ));
  }
}
