import 'package:flutter/material.dart';
import './babysitter_profile_screen.dart';
import '../widgets/input_box.dart';
import '../widgets/circle_button_one.dart';

class LoginScreen extends StatelessWidget {
  static final routeName = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_welcome_screen.jpg'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        padding: EdgeInsets.only(top: 50, left: 15, right: 15),
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
                ),
              ),
            ),
            InputBox(false, TextInputType.emailAddress, 'Email'),
            InputBox(true, TextInputType.text, 'Password'),
            CircleButtonOne(
              handler: () {
                Navigator.of(context)
                    .pushNamed(BabysitterProfileScreen.routeName);
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
    );
  }
}
