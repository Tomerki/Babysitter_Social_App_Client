import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './babysitter_profile_screen.dart';
import '../widgets/input_box.dart';
import '../widgets/circle_button_one.dart';

class LoginScreen extends StatelessWidget {
  static final routeName = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Color.fromARGB(255, 255, 229, 202),
        foregroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
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
