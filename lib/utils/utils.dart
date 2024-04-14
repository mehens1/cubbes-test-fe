import 'package:cubbes_test_fe/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String appName = 'Cubbes Test';
const String baseUrl = 'https://cubbes.sabicorporate.com/api';

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
    ),
  );
}

Future<void> checkUserLoggedIn(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.containsKey('userToken');

  if (!isLoggedIn) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
}

Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs
      .remove('userToken'); // Remove the userToken from SharedPreferences
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Login()),
  );
}
