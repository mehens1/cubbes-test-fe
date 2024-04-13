import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  // final String imagePath;
  // final double width;

  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Image.asset(
        'assets/images/Cubbes-Black.png',
        width: MediaQuery.of(context).size.width * 0.5,
      ),
    );
  }
}
