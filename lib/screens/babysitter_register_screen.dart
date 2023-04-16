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
  String age = '18';
  List<String> ageList =
      List.generate(165, (index) => (18 + (index * 0.5)).toStringAsFixed(1));

  Map<String, bool> texts = {
    'Come to client': false,
    'In my place': false,
    'Helping with housework': false,
    'knows how to cook': false,
    'First aid certified': false,
    'Has a driver\'s license': false,
    'Has past experience': false,
    'Has an education in education': false,
    'takes to activities': false,
  };

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
                  DropdownButtonFormField(
                    items: ageList.map((age) {
                      return DropdownMenuItem<String>(
                        value: age,
                        child: Text(double.parse(age)
                            .toStringAsFixed(age.endsWith('.0') ? 0 : 1)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        age = value!;
                      });
                    },
                    hint: Text(
                      'Selecet age',
                    ),
                    isExpanded: true,
                    icon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_drop_down),
                    ), // remove the default icon
                  ),
                  ...texts.keys.map(
                    (key) {
                      return CheckboxListTile(
                        value: texts[key],
                        onChanged: (val) {
                          setState(() {
                            texts[key] = val!;
                          });
                        },
                        title: Text(key),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
