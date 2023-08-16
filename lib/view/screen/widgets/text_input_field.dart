import 'package:flutter/material.dart';
import 'package:zippo/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isObsecured;
  final IconData icon;
  final TextInputType keyboardType;

  const TextInputField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.icon,
      this.isObsecured = false, required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: borderColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: borderColor,
            )),
      ),
      obscureText: isObsecured,
    );
  }
}
