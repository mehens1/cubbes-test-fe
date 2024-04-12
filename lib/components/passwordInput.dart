import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final IconData? icon;
  final TextInputType keyboardType;

  const PasswordInput({
    Key? key,
    required this.labelText,
    this.controller,
    this.validator,
    this.onChanged,
    this.icon,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isObscured = true; // Initially hide the password

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width * 0.75;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: deviceWidth,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _isObscured, // Use _isObscured to toggle visibility
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(),
          suffixIcon: widget.icon != null
              ? IconButton(
                  icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured; // Toggle visibility
                    });
                  },
                )
              : null,
        ),
        validator: widget.validator,
        onChanged: widget.onChanged,
      ),
    );
  }
}
