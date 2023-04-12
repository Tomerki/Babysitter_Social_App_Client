import 'package:baby_sitter/widgets/map_place_picker.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/input_box.dart';
import './babysitter_register_screen.dart';
import '../widgets/circle_button_one.dart';
import './parent_register_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String userType = '';
  String _selectedCountry = '';

  Widget buildSizedBox(String text) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: InputBox(
        keyType: TextInputType.name,
        text: text,
        validator: () {},
        onChanged: () {},
      ),
    );
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
        });
      },
      cMarginTop: 25,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Center(
        heightFactor: 1,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.only(top: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      buildSizedBox('First Name'),
                      buildSizedBox('Last Name'),
                    ],
                  ),
                  InputBox(
                    keyType: TextInputType.emailAddress,
                    text: 'Email',
                    validator: () {},
                    onChanged: () {},
                  ),
                  InputBox(
                    isSecure: true,
                    keyType: TextInputType.text,
                    text: 'Password',
                    validator: () {},
                    onChanged: () {},
                  ),
                  InputBox(
                    isSecure: true,
                    keyType: TextInputType.text,
                    text: 'Confirm Password',
                    validator: () {},
                    onChanged: () {},
                  ),
                  InputBox(
                    keyType: TextInputType.phone,
                    text: 'Phone Number',
                    validator: () {},
                    onChanged: () {},
                  ),
                  TextButton(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          _selectedCountry = country.name;
                        },
                      );
                    },
                    child: _selectedCountry != ''
                        ? Text(
                            _selectedCountry,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        : Text(
                            'Pick Country',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context)
                            .pushNamed(MapPlacePicker.routeName);
                      },
                      child: Text('Pick address')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCircleButtonOne('Parent'),
                      buildCircleButtonOne('Babysitter'),
                    ],
                  ),
                  CircleButtonOne(
                    handler: () {
                      if (userType == 'Parent') {
                        Navigator.of(context)
                            .pushNamed(ParentRegisterScreen.routeName);
                      } else if (userType == 'Babysitter') {
                        Navigator.of(context)
                            .pushNamed(BabysitterRegisterScreen.routeName);
                      }
                    },
                    text: 'Next',
                    cMarginTop: 30,
                    bgColor: Color.fromARGB(255, 150, 177, 190),
                    cWidth: 0.9,
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
