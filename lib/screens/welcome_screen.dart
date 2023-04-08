import './login_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/circle_button_one.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = 'welcome-screen';

  Widget buildRow(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          Icon(icon),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Babysitter'),
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
            child: Text(
              'Welcome to BabyMe!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
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
            textSize: 20,
            text: 'Click to login',
            cCircular: 20,
            cOpacity: 0.5,
            bgColor: Colors.black,
            textColor: Colors.white,
            cMarginTop: 70.0,
            cMarginBottom: 10.0,
            cPaddingTop: 10.0,
            cPaddingBottom: 10.0,
          ),
          CircleButtonOne(
            handler: () {},
            cWidth: 0.7,
            cHeight: 0.1,
            textSize: 20,
            text: 'Click to sign-up',
            cCircular: 20,
            cOpacity: 0.5,
            bgColor: Colors.black,
            textColor: Colors.white,
            cMarginTop: 10.0,
            cMarginBottom: 10.0,
            cPaddingTop: 10.0,
            cPaddingBottom: 10.0,
          ),
        ],
      ),
    );
  }
}
