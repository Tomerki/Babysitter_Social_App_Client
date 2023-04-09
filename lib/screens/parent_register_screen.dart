import 'package:baby_sitter/widgets/input_box.dart';
import 'package:flutter/material.dart';

class ParentRegisterScreen extends StatelessWidget {
  static const routeName = 'parent-register-screen';
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 100.0,
                ),
                SizedBox(
                  height: 48.0,
                ),
                InputBox(
                  validator: (String value) {
                    if (value.isEmpty) return "Name cannot be empty";
                  },
                  text: "Enter your name",
                  keyType: TextInputType.name,
                  onChanged: () {
                    // name = value;
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                InputBox(
                  validator: (String value) {
                    if (value.isEmpty) return "Street address cannot be empty";
                  },
                  keyType: TextInputType.streetAddress,
                  text: "Enter your Street Address",
                  onChanged: () {
                    // street = value;
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                InputBox(
                  validator: (String value) {
                    if (value.isEmpty) return "County cannot be empty";
                  },
                  keyType: TextInputType.text,
                  text: "Enter your County",
                  onChanged: () {
                    // county = value;
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                InputBox(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Phone number cannot be empty";
                    }
                  },
                  keyType: TextInputType.phone,
                  text: "Enter phone number",
                  onChanged: () {
                    // phone = value;
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
