import './register_screen.dart';

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
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
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
      appBar: AppBar(
        title: Center(
          child: Text('Babysitter'),
        ),
        backgroundColor: Color.fromARGB(255, 255, 229, 202),
        foregroundColor: Colors.black87,
      ),
      backgroundColor: Color.fromARGB(255, 255, 243, 226),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
            child: Text(
              'Welcome to BabyMe!',
              style: TextStyle(
                fontSize: 28,
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
            textSize: 20,
            text: 'Click to login',
            cCircular: 25,
            cOpacity: 0.8,
            bgColor: Color.fromARGB(255, 250, 152, 132),
            textColor: Colors.white,
            cMarginTop: 50.0,
            cMarginBottom: 30.0,
            cPaddingTop: 10.0,
            cPaddingBottom: 10.0,
          ),
          Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(RegisterScreen.routeName),
              splashColor: Colors.brown.withOpacity(0.5),
              child: Ink(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Sign-up now!',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Alkatra',
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/images/parents.jpg'),
                    fit: BoxFit.fill,
                    opacity: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
