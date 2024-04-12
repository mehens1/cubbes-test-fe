import 'package:cubbes_test_fe/pages/home.dart';
import 'package:cubbes_test_fe/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    _checkIfUserIsLoggedIn();
  }

  void _checkIfUserIsLoggedIn() {
    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool isLoggedIn = pref.containsKey('userToken');
      if (isLoggedIn) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

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
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
            const Padding(
              padding: EdgeInsets.all(50.0),
              child: Text('Version 1'),
            ),
          ],
        ),
      ),
    );
  }
}

// void showRetryDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("No Internet found!"),
//         content: const Text("Do you want to close the app or retry?"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               SystemNavigator.pop();
//             },
//             child: const Text("Close App"),
//           ),
//           // Retry option
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//               _WelcomeState? state =
//                   context.findAncestorStateOfType<_WelcomeState>();
//               if (state != null) {
//                 state._checkInternetConnection();
//               }
//             },
//             child: const Text("Retry"),
//           ),
//         ],
//       );
//     },
//   );
// }
