import 'package:flutter/material.dart';

class DropDownInput extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic>? value;
  final String hint;
  final ValueChanged<Map<String, dynamic>?> onChanged;

  const DropDownInput({
    required this.items,
    required this.value,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width * 0.75;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: deviceWidth,
      child: DropdownButtonFormField<Map<String, dynamic>>(
        value: value ?? null, // Use null if value is null
        hint: Text(
          hint,
          style: const TextStyle(color: Colors.grey),
        ),
        decoration: InputDecoration(
          // Styling for dropdown field
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        items: items.map<DropdownMenuItem<Map<String, dynamic>>>((item) {
          return DropdownMenuItem<Map<String, dynamic>>(
            value: item,
            child: Text(item['label']),
          );
        }).toList(),
        onChanged: (Map<String, dynamic>? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }
}
