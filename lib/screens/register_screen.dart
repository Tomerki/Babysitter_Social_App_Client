import 'dart:convert';
import 'dart:io';
import 'package:baby_sitter/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import '../models/appUser.dart';
import '../models/sharedPreferencesHelper.dart';
import '../server_manager.dart';
import 'package:flutter/material.dart';
import './login_screen.dart';
import '../services/auth.dart';
import '../widgets/loading.dart';
import '../widgets/map_place_picker.dart';
import '../services/validation.dart';
import 'babysitter_screens/babysitter_register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'register-screen';

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();

  var _formKey = GlobalKey<FormState>();
  String userType = 'Parent';
  String selectedCountry = '';
  Response? response;
  File? selectedImage;
  bool loading = false;
  bool isBabysitter = false;
  List<String> favorites = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  String? email,
      password,
      firstName,
      lastName,
      phoneNumber,
      address = 'Pick address',
      county,
      confirmPassword,
      imageUrl,
      defaultImage =
          "https://w7.pngwing.com/pngs/981/645/png-transparent-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette-symbol.png";

  callback(String newAddress) {
    setState(() {
      address = newAddress;
    });
  }

  Widget buildCircleButtonOne(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          userType = text;
          if (text == 'Babysitter') {
            isBabysitter = true;
          } else {
            isBabysitter = false;
          }
        });
      },
      child: Text(
        'I\'m a $text',
        style: GoogleFonts.workSans(
          textStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: userType == text ? Colors.white : Colors.black,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor:
            userType == text ? Colors.black.withOpacity(0.5) : Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                    fit: BoxFit.cover,
                    opacity: 0.3),
              ),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            UserImagePicker(
                              onPickImage: (pickedImage) {
                                selectedImage = pickedImage;
                              },
                            ),
                            Column(
                              children: [
                                Text(
                                  'SignUp',
                                  style: GoogleFonts.indieFlower(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "First Name cannot be empty";
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              firstName = value;
                                            });
                                          },
                                          keyboardType: TextInputType.name,
                                          decoration: const InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: Colors.purple,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "First Name",
                                            hintText: "first name",
                                            labelStyle:
                                                TextStyle(color: Colors.purple),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          validator: (String? value) {
                                            if (value!.isEmpty)
                                              return "Last Name cannot be empty";
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              lastName = value;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: Colors.purple,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "Last Name",
                                            hintText: 'last name',
                                            labelStyle:
                                                TextStyle(color: Colors.purple),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10, top: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Email field cannot be empty";
                                      } else if (emailAddressValidator(value)) {
                                        return 'Please Enter a valid email';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.purple,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Email",
                                      hintText: 'your-email@domain.com',
                                      labelStyle:
                                          TextStyle(color: Colors.purple),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: TextFormField(
                                    obscuringCharacter: '*',
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.purple,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Password",
                                      hintText: '*********',
                                      labelStyle:
                                          TextStyle(color: Colors.purple),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "password field cannot be empty";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10, top: 10),
                                  child: TextFormField(
                                    obscuringCharacter: '*',
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.purple,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Confirm Password",
                                      hintText: '*********',
                                      labelStyle:
                                          TextStyle(color: Colors.purple),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "confirm password field cannot be empty";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        confirmPassword = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Phone number cannot be empty";
                                      } else if (mobileNumberValidator(value)) {
                                        return "Please enter a valid mobile number";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        phoneNumber = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.purple,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Phone Number",
                                      hintText: 'phone number',
                                      labelStyle:
                                          TextStyle(color: Colors.purple),
                                    ),
                                  ),
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
                                    style: GoogleFonts.workSans(
                                      color: Colors.black,
                                      textStyle: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child:
                                              buildCircleButtonOne('Parent')),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: buildCircleButtonOne(
                                              'Babysitter')),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        backgroundColor: Colors.purple,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            vertical: 20)),
                                    onPressed: () async {
                                      if (_formKey.currentState == null) {
                                        print('_formKey.currentState == null');
                                      } else if (_formKey.currentState!
                                          .validate()) {
                                        if (confirmPassword == password) {
                                          setState(() {
                                            loading = true;
                                          });
                                          dynamic result = await _auth
                                              .registerWithEmailAndpassword(
                                            email!,
                                            password!,
                                          );
                                          if (result == null) {
                                            setState(() {
                                              loading = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                "email already in the system",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ));
                                          } else {
                                            if (selectedImage != null) {
                                              final storageRef = FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child('user_images')
                                                  .child('${result.uid}.jpg');

                                              await storageRef
                                                  .putFile(selectedImage!);
                                              imageUrl = await storageRef
                                                  .getDownloadURL();
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
                                                        'phoneNumber':
                                                            phoneNumber,
                                                        'address': address ==
                                                                'Pick address'
                                                            ? 'Africam Safari, Blvd. Capitán Carlos Camacho Espíritu, Oasis, Puebla, Mexico'
                                                            : address,
                                                        'county':
                                                            selectedCountry,
                                                        'image':
                                                            imageUrl != null
                                                                ? imageUrl
                                                                : defaultImage
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
                                                        'phoneNumber':
                                                            phoneNumber,
                                                        'address': address ==
                                                                'Pick address'
                                                            ? 'Africam Safari, Blvd. Capitán Carlos Camacho Espíritu, Oasis, Puebla, Mexico'
                                                            : address,
                                                        'county':
                                                            selectedCountry,
                                                        'image':
                                                            imageUrl != null
                                                                ? imageUrl
                                                                : defaultImage,
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
                                                    'uid':
                                                        result.uid.toString(),
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
                                            } else if (userType ==
                                                'Babysitter') {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                BabysitterRegisterScreen
                                                    .routeName,
                                                arguments: json.decode(
                                                    response!.body)['id'],
                                              );
                                            }
                                            SharedPreferencesHelper
                                                .clearLoggedInUser();
                                            AppUser.deleteInstance();
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              "Passwords don't match",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ));
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.workSans(
                                        textStyle: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'already have an account?',
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              },
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.workSans(
                                  color: Colors.purple,
                                  textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
