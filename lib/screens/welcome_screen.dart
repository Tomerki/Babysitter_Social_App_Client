import '../services/auth.dart';
import './register_screen.dart';

import './login_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/circle_button_one.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = 'welcome-screen';
  final AuthService _auth = AuthService();

  Widget buildRow(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 232, 226, 226),
              Color.fromARGB(255, 189, 158, 158),
              Color.fromARGB(255, 178, 157, 137),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0, bottom: 30.0),
              child: Text(
                'Welcome to BabyMe',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Alkatra',
                ),
              ),
            ),
            buildRow('Finding nanny from everywhere!', Icons.public),
            buildRow('Easy and Simple to use!', Icons.accessibility_new),
            buildRow('Safety for your child!', Icons.safety_check),
            CircleButtonOne(
              handler: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              cWidth: 0.7,
              cHeight: 0.1,
              textSize: 21,
              text: 'Click to Login',
              cCircular: 25,
              cOpacity: 0.8,
              bgColor: Color.fromARGB(255, 231, 70, 70),
              textColor: Colors.white,
              cMarginTop: 70.0,
              cMarginBottom: 20.0,
              cPaddingTop: 10.0,
              cPaddingBottom: 10.0,
            ),
            CircleButtonOne(
              handler: () {
                Navigator.of(context).pushNamed(RegisterScreen.routeName);
              },
              cWidth: 0.7,
              cHeight: 0.1,
              textSize: 21,
              text: 'Click to Sign-Up',
              cCircular: 25,
              cOpacity: 0.8,
              bgColor: Color.fromARGB(255, 231, 70, 70),
              textColor: Colors.white,
              cMarginTop: 20.0,
              cMarginBottom: 30.0,
              cPaddingTop: 10.0,
              cPaddingBottom: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
