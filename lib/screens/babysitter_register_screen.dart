import 'dart:io';
import 'package:baby_sitter/widgets/check_box_custome.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/input_box.dart';

class BabysitterRegisterScreen extends StatefulWidget {
  static const routeName = 'babysitter-register-screen';

  @override
  State<BabysitterRegisterScreen> createState() =>
      _BabysitterRegisterScreenState();
}

class _BabysitterRegisterScreenState extends State<BabysitterRegisterScreen> {
  final _formKey2 = GlobalKey<FormState>();
  File? _imageFile;
  bool isChecked = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        heightFactor: 1,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.only(top: 30),
          child: Form(
            key: _formKey2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('About me:'),
                  Card(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 5,
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your text here"),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  if (_imageFile != null) ...[
                    Image.file(
                      _imageFile!,
                      width: 150,
                      height: 150,
                    ),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: Text('Pick another image'),
                    ),
                  ] else ...[
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: Text('Pick Profile Image'),
                    ),
                    Text('No image selected'),
                  ],
                  InputBox(
                    keyType: TextInputType.number,
                    text: 'Your age',
                    validator: () {},
                    onChanged: () {},
                  ),
                  CheckBoxCustome(text: 'Come to client'),
                  CheckBoxCustome(text: 'In my place'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
