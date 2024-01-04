import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewTaskTextForm extends StatelessWidget {
  NewTaskTextForm({
    super.key,
    required this.controllTaskName,
    required this.labelText,
    this.maxLines = 1,
  });

  final TextEditingController controllTaskName;
  final String labelText;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(25)),
      child: TextFormField(
        controller: controllTaskName,
        validator: (val) {
          if (val!.isEmpty) {}
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.roboto(),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
