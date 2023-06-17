import 'dart:convert';
import 'package:baby_sitter/screens/login_screen.dart';
import 'package:baby_sitter/server_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BabysitterRegisterScreen extends StatefulWidget {
  static const routeName = 'babysitter-register-screen';

  @override
  State<BabysitterRegisterScreen> createState() =>
      _BabysitterRegisterScreenState();
}

class _BabysitterRegisterScreenState extends State<BabysitterRegisterScreen> {
  final _formKey2 = GlobalKey<FormState>();
  String about = '';
  double price = -1.0;
  String age = '18';
  List<String> ageList =
      List.generate(165, (index) => (18 + (index * 0.5)).toStringAsFixed(1));
  bool good = true;

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                fit: BoxFit.cover,
                opacity: 0.3)),
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
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'About',
                            style: GoogleFonts.workSans(
                              color: Colors.black.withOpacity(0.5),
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 50,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Me',
                            style: GoogleFonts.workSans(
                              color: Colors.black.withOpacity(0.5),
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 40,
                              ),
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
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(color: good ? Colors.white : Colors.red),
                    ),
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(
                            () {
                              about = value;
                            },
                          );
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
                      'select age',
                    ),
                    isExpanded: true,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'price per hour',
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
                ElevatedButton(
                  child: Text(
                    'Sign Up!',
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Colors.purple,
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                  onPressed: () async {
                    ServerManager.checkLanguage(about).then(
                      (value) async {
                        if (!value) {
                          setState(
                            () {
                              good = true;
                            },
                          );
                          String id = ModalRoute.of(context)!.settings.arguments
                              as String;
                          await ServerManager()
                              .putRequest(
                                'items/$id',
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
                              .then((value) => Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName));
                        } else {
                          setState(
                            () {
                              good = false;
                            },
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 122, 25, 18),
                              behavior: SnackBarBehavior.floating,
                              elevation: 5,
                              content: Text(
                                "Please use an appropriate language!",
                                style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
