import 'package:flutter/material.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputBox(
                isSecure: false,
                keyType: TextInputType.name,
                text: 'First Name',
                validator: () {},
                onChanged: () {},
              ),
              InputBox(
                isSecure: false,
                keyType: TextInputType.name,
                text: 'Last Name',
                validator: () {},
                onChanged: () {},
              ),
              InputBox(
                isSecure: false,
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
    );
  }
}
