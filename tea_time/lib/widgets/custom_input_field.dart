import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    required this.controller,
    required this.hint,
    required this.validator,
    this.obscureText = false,
    this.capitalization = TextCapitalization.none,
    this.inputType = TextInputType.text,
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final String? Function(String?) validator;
  final TextCapitalization capitalization;
  final TextInputType inputType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          filled: true,
          hintText: hint,
        ),
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        validator: validator,
        textCapitalization: capitalization,
        maxLines: maxLines,
      ),
    );
  }
}
