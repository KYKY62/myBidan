import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final bool filled;
  final Color inputColor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    this.obscureText = false,
    this.filled = false,
    this.prefixIcon,
    this.textStyle,
    required this.inputColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(color: inputColor),
        decoration: InputDecoration(
          hintStyle: textStyle,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          hintText: label,
          filled: filled,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
