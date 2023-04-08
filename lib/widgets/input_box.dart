import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final bool isSecure;
  final TextInputType keyType;
  final String text;

  InputBox(this.isSecure, this.keyType, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        obscureText: isSecure,
        keyboardType: keyType,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
