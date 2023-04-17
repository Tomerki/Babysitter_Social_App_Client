import 'dart:io';
import 'package:baby_sitter/screens/login_screen.dart';
import 'package:baby_sitter/widgets/circle_button_one.dart';
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 201, 195, 195),
              Color.fromARGB(255, 179, 175, 175),
              Color.fromARGB(255, 183, 160, 160),
            ],
          ),
        ),
        child: Form(
          key: _formKey2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(top: 60, bottom: 30, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (_imageFile != null) ...[
                        FloatingActionButton.large(
                          backgroundColor: Colors.grey[300],
                          onPressed: () => _pickImage(ImageSource.gallery),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(_imageFile!),
                                fit: BoxFit.fill,
                              ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ] else ...[
                        FloatingActionButton.large(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black,
                          onPressed: () => _pickImage(ImageSource.gallery),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo,
                              ),
                              Text(
                                'Profile Picture',
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ],
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'About',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Me',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        maxLines: 6,
                        decoration: InputDecoration.collapsed(
                            hintText: "Tell us more about you..."),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: DropdownButtonFormField(
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
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
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, bottom: 15),
                  child: Text(
                    'Your skills:',
                    style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 2,
                      letterSpacing: 2,
                    ),
                  ),
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
                CircleButtonOne(
                  handler: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  text: 'Sign-up!',
                  cWidth: 0.8,
                  cHeight: 0.1,
                  cPaddingBottom: 20,
                  bgColor: Colors.black,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
