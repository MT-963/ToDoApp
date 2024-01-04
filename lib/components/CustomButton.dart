import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.onPressed, required this.buttonText});

  final void Function()? onPressed;
  final String buttonText;
  @override
  Widget build(BuildContext context) => MaterialButton(
      height: 40,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.black)),
      onPressed: onPressed,
      color: Colors.green,
      child: Text(buttonText,
          style: const TextStyle(
            color: Colors.white,
          )));
}
