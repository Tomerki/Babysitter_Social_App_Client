import 'dart:convert';
import 'dart:io';
import 'package:baby_sitter/screens/login_screen.dart';
import 'package:baby_sitter/server_manager.dart';
import 'package:baby_sitter/widgets/circle_button_one.dart';
import 'package:baby_sitter/widgets/loading.dart';
import 'package:baby_sitter/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/src/response.dart';

import '../models/appUser.dart';
import 'babysitter_main_screen.dart';

class EditBabysitterProfileScreen extends StatefulWidget {
  final Map<String, bool> texts;
  String? about;
  double? price;
  String? age;

  static const routeName = 'babysitter-register-screen';

  EditBabysitterProfileScreen({
    super.key,
    required this.texts,
    this.about = '',
    this.price = -0.1,
    this.age = '18',
  });

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

  TextEditingController _aboutController = TextEditingController(text: '');

  List<String> ageList =
      List.generate(165, (index) => (18 + (index * 0.5)).toStringAsFixed(1));

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

            // about = babysitter['about'];
            // price = babysitter['price'];

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(188, 227, 183, 160),
                    Color.fromARGB(255, 236, 232, 217),
                    Color.fromARGB(255, 250, 246, 233),
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
                                  'About   ',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Me',
                                  style: TextStyle(
                                    color: Colors.black54,
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
                                  widget.about = value;
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
                              widget.age = value!;
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
                              widget.price = double.parse(value);
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
                      ...widget.texts.keys.map(
                        (key) {
                          return CheckboxListTile(
                            value: widget.texts[key],
                            onChanged: (val) {
                              setState(() {
                                widget.texts[key] = val!;
                              });
                            },
                            title: Text(key),
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        },
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: CircleButtonOne(
                              handler: () async {
                                await ServerManager()
                                    .putRequest(
                                  'items/' + AppUser.getUid(),
                                  'Babysitter',
                                  body: jsonEncode(
                                    {
                                      'price':
                                          widget.price == '' ? 0 : widget.price,
                                      'about': widget.about,
                                      'age': widget.age,
                                      'ComeToClient': widget
                                          .texts['Come to client']
                                          .toString(),
                                      'InMyPlace': widget.texts['In my place']
                                          .toString(),
                                      'HelpingWithHouseWork': widget
                                          .texts['Helping with housework']
                                          .toString(),
                                      'KnowsHowToCook': widget
                                          .texts['Knows how to cook']
                                          .toString(),
                                      'FirstAidCertified': widget
                                          .texts['First aid certified']
                                          .toString(),
                                      'HasDriverLicense': widget
                                          .texts['Has a driver\'s license']
                                          .toString(),
                                      'HasPastExperience': widget
                                          .texts['Has past experience']
                                          .toString(),
                                      'HasAnEducationInEducation': widget.texts[
                                              'Has an education in education']
                                          .toString(),
                                      'TakesToActivities': widget
                                          .texts['Takes to/from activities']
                                          .toString(),
                                      'ChangeADiaper': widget
                                          .texts['Change a diaper']
                                          .toString(),
                                    },
                                  ),
                                )
                                    .then((value) async {
                                  await ServerManager()
                                      .getRequest('items/' + AppUser.getUid(),
                                          'Babysitter')
                                      .then((val) {
                                    Navigator.of(context).popAndPushNamed(
                                      BabysitterMainScreen.routeName,
                                      arguments: val.body,
                                    );
                                  });
                                });
                              },
                              text: 'Save Changes',
                              cHeight: 0.1,
                              cPaddingBottom: 20,
                              bgColor: Colors.black,
                              textColor: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: CircleButtonOne(
                              handler: () async {
                                await ServerManager()
                                    .getRequest('items/' + AppUser.getUid(),
                                        'Babysitter')
                                    .then((val) {
                                  Navigator.of(context).popAndPushNamed(
                                    BabysitterMainScreen.routeName,
                                    arguments: val.body,
                                  );
                                });
                              },
                              text: 'Cancel',
                              cHeight: 0.1,
                              cPaddingBottom: 20,
                              bgColor: Color.fromARGB(255, 81, 26, 26),
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      )
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
