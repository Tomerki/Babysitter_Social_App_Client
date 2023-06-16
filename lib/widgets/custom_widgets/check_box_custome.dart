import 'package:flutter/material.dart';

class CheckBoxCustome extends StatefulWidget {
  final String text;
  const CheckBoxCustome({super.key, required this.text});

  @override
  State<CheckBoxCustome> createState() => _CheckBoxCustomeState();
}

class _CheckBoxCustomeState extends State<CheckBoxCustome> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.text),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
