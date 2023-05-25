import 'package:baby_sitter/server_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './jobs_search_screen.dart';
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
  final AuthService _auth = AuthService();
  var _formKey = GlobalKey<FormState>();
  bool loading = false;
  String? email, password;
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
                        if (_formKey.currentState == null) {
                          print('_formKey.currentState == null');
                        } else if (_formKey.currentState!.validate()) {
                          setState(() {
                            () => loading = true;
                          });

                          dynamic result = await _auth
                              .signInWithEmailAndpassword(email!, password!);
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
                            var jobs = await ServerManager()
                                .getRequest('items', 'Jobs')
                                .then((value) {
                              print(value.body);
                            });
                            print(jobs);
                            Navigator.of(context)
                                .popAndPushNamed(JobsSearchScreen.routeName);
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
