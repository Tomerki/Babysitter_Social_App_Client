import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BabysitterRegisterScreen extends StatefulWidget {
  static const routeName = 'babysitter-register-screen';

  @override
  State<BabysitterRegisterScreen> createState() =>
      _BabysitterRegisterScreenState();
}

class _BabysitterRegisterScreenState extends State<BabysitterRegisterScreen> {
  final _formKey2 = GlobalKey<FormState>();
  File? _imageFile;

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
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.only(top: 30),
          child: Form(
            key: _formKey2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_imageFile != null) ...[
                    Image.file(
                      _imageFile!,
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: Text('Pick another image'),
                    ),
                  ] else ...[
                    Text('No image selected'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: Text('Pick an image'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
