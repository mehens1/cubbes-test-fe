import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const SmallButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8.0),
          child: Center(
            child: Ink(
              // width: MediaQuery.of(context).size.width * 0.5,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 100.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
