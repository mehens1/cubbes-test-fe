import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final IconData? icon;
  final TextInputType keyboardType;

  const TextInput({
    Key? key,
    required this.labelText,
    this.controller,
    this.validator,
    this.onChanged,
    this.icon,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width * 0.75;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: deviceWidth,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          suffixIcon: icon != null ? Icon(icon) : null,
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
