import 'dart:convert';
import 'dart:io';

import 'package:baby_sitter/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

import '../server_manager.dart';
import 'package:flutter/material.dart';
import './login_screen.dart';
import '../services/auth.dart';
import '../widgets/loading.dart';
import '../widgets/map_place_picker.dart';
import '../services/validation.dart';
import '../widgets/input_box.dart';
import './babysitter_register_screen.dart';
import '../widgets/circle_button_one.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  //instance of firestore

  // final _firestore = FirebaseFirestore.instance;
  var _formKey = GlobalKey<FormState>();
  String userType = '';
  String _selectedCountry = '';
  Response? response;
  File? _selectedImage;
  bool loading = false;
  bool isBabysitter = false;
  List<String> favorites = [];

  String? email,
      password,
      firstName,
      lastName,
      phoneNumber,
      address = 'Pick address',
      county,
      confirmPassword,
      imageUrl;

  callback(String newAddress) {
    setState(() {
      address = newAddress;
    });
  }

  Widget buildCircleButtonOne(String text) {
    return CircleButtonOne(
      text: 'I\'m a $text',
      bgColor: userType == text ? Colors.black : Colors.white,
      textColor: userType == text ? Colors.white : Colors.black,
      cWidth: 0.4,
      handler: () {
        setState(() {
          userType = text;
          if (text == 'Babysitter') {
            isBabysitter = true;
          }
        });
      },
      cMarginTop: 25,
    );
  }

  // String? createValidator(String value, String type, String text, bool secure) {
  //   if (value.isEmpty) {
  //     return "$type field cannot be empty";
  //   } else if (secure
  //       ? minLengthValidator(6, value)
  //       : emailAddressValidator(value)) {
  //     return text;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 201, 195, 195),
                    Color.fromARGB(255, 185, 170, 170),
                    Color.fromARGB(255, 191, 155, 155),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 40, bottom: 20, right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          UserImagePicker(
                            onPickImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Welcome',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: InputBox(
                                  keyType: TextInputType.name,
                                  text: 'First Name',
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "First Name cannot be empty";
                                    }
                                  },
                                  onChanged: (value) {
                                    firstName = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: InputBox(
                                  keyType: TextInputType.name,
                                  text: 'Last Name',
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return "Last Name cannot be empty";
                                  },
                                  onChanged: (value) {
                                    lastName = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          InputBox(
                            keyType: TextInputType.emailAddress,
                            text: 'Email',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Email field cannot be empty";
                              } else if (emailAddressValidator(value)) {
                                return 'Please Enter a valid email';
                              }
                            },
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          InputBox(
                            isSecure: true,
                            keyType: TextInputType.text,
                            text: 'Password',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "pasaword field cannot be empty";
                              } else if (minLengthValidator(6, value)) {
                                return 'Password must be minimum 6 characters';
                              }
                            },
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          InputBox(
                            isSecure: true,
                            keyType: TextInputType.text,
                            text: 'Confirm Password',
                            validator: (String value) {
                              if (value.isEmpty)
                                return "confirm Password cannot be empty";
                            },
                            onChanged: (value) {
                              confirmPassword = value;
                            },
                          ),
                          InputBox(
                            keyType: TextInputType.phone,
                            text: 'Phone Number',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Phone number cannot be empty";
                              } else if (mobileNumberValidator(value)) {
                                return "Please enter a valid mobile number";
                              }
                            },
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pushNamed(
                                MapPlacePicker.routeName,
                                arguments: callback,
                              );
                            },
                            child: Text(
                              address!,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buildCircleButtonOne('Parent'),
                              buildCircleButtonOne('Babysitter'),
                            ],
                          ),
                          CircleButtonOne(
                            handler: () async {
                              if (_formKey.currentState == null) {
                                print('_formKey.currentState == null');
                              } else if (_formKey.currentState!.validate()) {
                                if (confirmPassword == password) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.registerWithEmailAndpassword(
                                    email!,
                                    password!,
                                  );
                                  if (result == null) {
                                    print('not good');
                                    setState(() {
                                      loading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "email already in the system",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ));
                                  } else {
                                    if (_selectedImage != null) {
                                      final storageRef = FirebaseStorage
                                          .instance
                                          .ref()
                                          .child('user_images')
                                          .child('${result.uid}.jpg');

                                      await storageRef.putFile(_selectedImage!);
                                      imageUrl =
                                          await storageRef.getDownloadURL();
                                    }
                                    await ServerManager()
                                        .postRequest(
                                      'add_doc/' + result.uid,
                                      userType,
                                      body: isBabysitter
                                          ? jsonEncode(
                                              {
                                                'uid': result.uid,
                                                'email': email,
                                                'firstName': firstName,
                                                'lastName': lastName,
                                                'fullName': firstName! +
                                                    ' ' +
                                                    lastName!,
                                                'phoneNumber': phoneNumber,
                                                'address': address,
                                                'county': _selectedCountry,
                                                'image': imageUrl,
                                              },
                                            )
                                          : jsonEncode(
                                              {
                                                'uid': result.uid,
                                                'email': email,
                                                'firstName': firstName,
                                                'lastName': lastName,
                                                'fullName': firstName! +
                                                    ' ' +
                                                    lastName!,
                                                'phoneNumber': phoneNumber,
                                                'address': address,
                                                'county': _selectedCountry,
                                                'image': imageUrl,
                                                'favorites': favorites,
                                              },
                                            ),
                                    )
                                        .then((value) async {
                                      await ServerManager()
                                          .postRequest(
                                        'add_doc',
                                        'Users',
                                        body: jsonEncode(
                                          {
                                            'uid': result.uid.toString(),
                                            'isBabysitter': isBabysitter
                                          },
                                        ),
                                      )
                                          .then((value) {
                                        setState(
                                          () {
                                            response = value;
                                          },
                                        );
                                      });
                                      setState(
                                        () {
                                          response = value;
                                        },
                                      );
                                    });

                                    Navigator.of(context).pop();
                                    if (userType == 'Parent') {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        LoginScreen.routeName,
                                      );
                                    } else if (userType == 'Babysitter') {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        BabysitterRegisterScreen.routeName,
                                        arguments:
                                            json.decode(response!.body)['id'],
                                      );
                                    }
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Passwords don't match",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ));
                                }
                              } else {
                                print('not good');
                              }
                            },
                            cOpacity: 0.8,
                            text: 'Next',
                            cMarginTop: 30,
                            bgColor: Colors.black,
                            textColor: Colors.white,
                            cWidth: 0.9,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
