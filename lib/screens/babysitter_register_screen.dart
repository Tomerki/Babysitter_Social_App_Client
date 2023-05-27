import 'dart:convert';
import 'dart:io';
import 'package:baby_sitter/screens/login_screen.dart';
import 'package:baby_sitter/server_manager.dart';
import 'package:baby_sitter/widgets/circle_button_one.dart';
import 'package:baby_sitter/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class BabysitterRegisterScreen extends StatefulWidget {
  static const routeName = 'babysitter-register-screen';

  @override
  State<BabysitterRegisterScreen> createState() =>
      _BabysitterRegisterScreenState();
}

class _BabysitterRegisterScreenState extends State<BabysitterRegisterScreen> {
  final _formKey2 = GlobalKey<FormState>();
  File? _imageFile;
  String about = '';
  String age = '18';
  List<String> ageList =
      List.generate(165, (index) => (18 + (index * 0.5)).toStringAsFixed(1));

  Map<String, bool> texts = {
    'Come to client': false,
    'In my place': false,
    'Helping with housework': false,
    'Knows how to cook': false,
    'First aid certified': false,
    'Has a driver\'s license': false,
    'Has past experience': false,
    'Has an education in education': false,
    'Takes to activities': false,
  };

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
                        onChanged: (value) {
                          setState(() {
                            about = value;
                          });
                        },
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
                  handler: () async {
                    String id =
                        ModalRoute.of(context)!.settings.arguments as String;
                    await ServerManager()
                        .putRequest(
                          'items/$id',
                          'Babysitter',
                          body: jsonEncode(
                            {
                              'about': about,
                              'age': age,
                              'ComeToClient':
                                  texts['Come to client'].toString(),
                              'InMyPlace': texts['In my place'].toString(),
                              'HelpingWithHouseWork':
                                  texts['Helping with housework'].toString(),
                              'KnowsHowToCook':
                                  texts['Knows how to cook'].toString(),
                              'FirstAidCertified':
                                  texts['First aid certified'].toString(),
                              'HasDriverLicense':
                                  texts['Has a driver\'s license'].toString(),
                              'HasPastExperience':
                                  texts['Has past experience'].toString(),
                              'HasAnEducationInEducation':
                                  texts['Has an education in education']
                                      .toString(),
                              'TakesToActivities':
                                  texts['Takes to activities'].toString(),
                            },
                          ),
                        )
                        .then((value) => Navigator.of(context)
                            .pushNamed(LoginScreen.routeName));
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
