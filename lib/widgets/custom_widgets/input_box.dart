import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputBox extends StatelessWidget {
  final bool isSecure;
  final TextInputType keyType;
  final String text;
  final Function validator;
  final Function onChanged;

  InputBox({
    this.isSecure = false,
    required this.keyType,
    required this.text,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        validator: (value) => validator(value),
        obscureText: isSecure,
        keyboardType: keyType,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: GoogleFonts.workSans(
            color: Colors.black,
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
