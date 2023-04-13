// import 'package:flutter/material.dart';

// const kPrimaryColor = Colors.white;
// const kSecondaryColor = Colors.black;
// const kTextColorLight = Colors.white60;
// const kMediumDarkText = Colors.black54;

// class CustomLargeTextField extends StatelessWidget {
//   final String? hintText;
//   final bool? isObscure;
//   final Function onChanged;
//   final TextInputType? inputType;
//   final Function? validator;

//   CustomLargeTextField(
//       {this.hintText,
//       required this.onChanged,
//       this.isObscure = false,
//       this.inputType,
//       this.validator});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       // validator: validator,
//       keyboardType: inputType,
//       onChanged: onChanged,
//       style: TextStyle(color: kSecondaryColor),
//       textAlign: TextAlign.center,
//       obscureText: isObscure,
//       textInputAction: TextInputAction.next,
//       autofocus: true,
//       decoration: InputDecoration(
//         hintText: hintText,
//         contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(32.0)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: kSecondaryColor, width: 1.0),
//           borderRadius: BorderRadius.all(Radius.circular(32.0)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: kSecondaryColor, width: 2.0),
//           borderRadius: BorderRadius.all(Radius.circular(32.0)),
//         ),
//       ),
//     );
//   }
// }
