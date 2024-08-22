import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final bool filled;
  final bool? readOnly;
  final Color inputColor;
  final double? padding;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmit;
  final List<TextInputFormatter>? inputFormatters;

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
    this.padding,
    this.inputFormatters,
    this.readOnly,
    this.onChange,
    this.onFieldSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(color: inputColor),
        inputFormatters: inputFormatters ?? [],
        readOnly: readOnly ?? false,
        onChanged: onChange ?? (value) {},
        onFieldSubmitted: onFieldSubmit ?? (value) {},
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
