import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/Cubbes-Black.png',
          width: MediaQuery.of(context).size.width * 0.5,
          // width: 100,
        ), //Image(image: AssetImage('assets/')),
      ),
    );
  }
}
