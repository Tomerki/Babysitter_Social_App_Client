import 'dart:convert';
import 'package:baby_sitter/screens/babysitter_main_screen.dart';
import 'package:baby_sitter/screens/chat_page_screen.dart';
import 'package:baby_sitter/screens/parent_main_screen.dart';
import 'package:baby_sitter/server_manager.dart';
import 'package:flutter/material.dart';
import '../models/appUser.dart';
import '../widgets/loading.dart';
import '../services/auth.dart';
import '../services/validation.dart';
import '../widgets/input_box.dart';
import '../widgets/circle_button_one.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    print("init state of login");
    super.initState();
  }

  final AuthService _auth = AuthService();
  var _formKey = GlobalKey<FormState>();
  bool loading = false;
  String? email, password;

  bool isBabysitter = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_welcome_screen.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
              ),
              padding: EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Text(
                        'BabyMe',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Alkatra',
                        ),
                      ),
                    ),
                    InputBox(
                      isSecure: false,
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
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    CircleButtonOne(
                      handler: () async {
                        print(AppUser.getUserType());
                        // FocusNode().unfocus();
                        if (_formKey.currentState == null) {
                          print('_formKey.currentState == null');
                        } else if (_formKey.currentState!.validate()) {
                          setState(() {
                            () => loading = true;
                          });
                          var result = await _auth.signInWithEmailAndpassword(
                              email!, password!);
                          print(email);
                          print(password);
                          print(result.uid);
                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "email or password incorrect",
                                style: TextStyle(color: Colors.black),
                              ),
                            ));
                            setState(() {
                              () => loading = false;
                            });
                          } else {
                            await ServerManager()
                                .getRequest(
                                    'search/uid/' + result.uid.toString(),
                                    'Users')
                                .then((value) async {
                              isBabysitter = json.decode(
                                  value.body.toString())['isBabysitter'];

                              final type =
                                  isBabysitter ? 'Babysitter' : 'Parent';
                              AppUser.setUserKind(isBabysitter);
                              AppUser.setUserType(type);
                              if (isBabysitter) {
                                await ServerManager()
                                    .getRequest(
                                        'search/email/' + email!, 'Babysitter')
                                    .then((user) {
                                  Navigator.of(context).popAndPushNamed(
                                    BabysitterMainScreen.routeName,
                                    arguments: user.body,
                                  );
                                });
                              } else {
                                await ServerManager()
                                    .getRequest(
                                        'search/email/' + email!, 'Parent')
                                    .then((user) {
                                  Navigator.of(context).popAndPushNamed(
                                    ParentMainScreen.routeName,
                                    arguments: user.body,
                                  );
                                  // Navigator.of(context).popAndPushNamed(
                                  //   ChatPageScreen.routeName,
                                  //   arguments: user.body,
                                  // );
                                });
                              }
                            });
                          }
                        } else {
                          print('not good');
                        }
                      },
                      cWidth: 0.32,
                      cHeight: 0.08,
                      textSize: 23,
                      cOpacity: 0.5,
                      cCircular: 20,
                      cPaddingTop: 10,
                      text: 'Login',
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
