import 'dart:convert';
import 'dart:io';
import 'package:baby_sitter/screens/login_screen.dart';
import 'package:baby_sitter/server_manager.dart';
import 'package:baby_sitter/widgets/circle_button_one.dart';
import 'package:baby_sitter/widgets/loading.dart';
import 'package:baby_sitter/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/appUser.dart';

class EditBabysitterProfileScreen extends StatefulWidget {
  static const routeName = 'babysitter-register-screen';

  @override
  State<EditBabysitterProfileScreen> createState() =>
      _EditBabysitterProfileScreenState();
}

class _EditBabysitterProfileScreenState
    extends State<EditBabysitterProfileScreen> {
  Future<dynamic>? babysitterFuture;
  Future<dynamic> fetchBabysitter() async {
    final result = await ServerManager()
        .getRequest('items/' + AppUser.getUid(), 'Babysitter');
    return json.decode(result.body);
  }

  @override
  void initState() {
    babysitterFuture = fetchBabysitter();
    super.initState();
  }

  final _formKey2 = GlobalKey<FormState>();
  File? _imageFile;
  String about = '';
  TextEditingController _aboutController = TextEditingController(text: '');

  double price = -1.0;
  String age = '18';
  List<String> ageList =
      List.generate(165, (index) => (18 + (index * 0.5)).toStringAsFixed(1));

  Map<String, bool> texts = {
    'Come to client': false,
    'In my place': false,
    'Takes to/from activities': false,
    'Knows how to cook': false,
    'First aid certified': false,
    'Helping with housework': false,
    'Has a driver\'s license': false,
    'Change a diaper': false,
    'Has past experience': false,
    'Has an education in education': false,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: babysitterFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the future to complete, show a progress indicator
            return Loading();
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            dynamic babysitter = snapshot.data;
            _aboutController.text = babysitter['about'];
            about = babysitter['about'];

            return Container(
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
                        padding: const EdgeInsets.only(
                            top: 60, bottom: 30, right: 20),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              // controller: _aboutController,
                              onChanged: (value) {
                                setState(() {
                                  about = value;
                                });
                              },
                              maxLines: 6,
                              decoration: InputDecoration.collapsed(
                                  hintText: babysitter['about']),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: DropdownButtonFormField(
                          menuMaxHeight:
                              MediaQuery.of(context).size.height * 0.5,
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
                            babysitter['age'],
                          ),
                          isExpanded: true,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: babysitter['price'] > 0
                                ? babysitter['price'].toString()
                                : 'price per hour',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              price = double.parse(value);
                            });
                          },
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
                          await ServerManager()
                              .putRequest(
                                'items/' + AppUser.getUid(),
                                'Babysitter',
                                body: jsonEncode(
                                  {
                                    'price': price == '' ? 0 : price,
                                    'about': about,
                                    'age': age,
                                    'ComeToClient':
                                        texts['Come to client'].toString(),
                                    'InMyPlace':
                                        texts['In my place'].toString(),
                                    'HelpingWithHouseWork':
                                        texts['Helping with housework']
                                            .toString(),
                                    'KnowsHowToCook':
                                        texts['Knows how to cook'].toString(),
                                    'FirstAidCertified':
                                        texts['First aid certified'].toString(),
                                    'HasDriverLicense':
                                        texts['Has a driver\'s license']
                                            .toString(),
                                    'HasPastExperience':
                                        texts['Has past experience'].toString(),
                                    'HasAnEducationInEducation':
                                        texts['Has an education in education']
                                            .toString(),
                                    'TakesToActivities':
                                        texts['Takes to/from activities']
                                            .toString(),
                                    'ChangeADiaper':
                                        texts['Change a diaper'].toString(),
                                  },
                                ),
                              )
                              .then((value) => Navigator.of(context).pop());
                        },
                        text: 'Save Changes',
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
            );
          }
        },
      ),
    );
  }
}
