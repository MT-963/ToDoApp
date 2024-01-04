import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(
      {super.key,
      required this.controller,
      required this.validator,
      required this.labelText,
      this.textInputType = TextInputType.text,
      this.obsecureText = false,
      required this.icon,
      this.maxLines = 1});

  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? labelText;
  final TextInputType textInputType;
  final bool obsecureText;
  final IconData? icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(top: 5),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obsecureText,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          focusColor: Colors.white,
          labelText: labelText,
          labelStyle: GoogleFonts.roboto(),
          prefixIcon: Icon(icon),
          prefixIconColor: Colors.green,
          filled: true,
          fillColor: Colors.grey[200],
          errorStyle: const TextStyle(
            color: Colors.black,
            height: 0.5,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}
