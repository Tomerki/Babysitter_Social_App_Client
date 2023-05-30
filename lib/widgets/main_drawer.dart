import 'package:baby_sitter/screens/filter_screen.dart';
import 'package:baby_sitter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class MainDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        // style: TextStyle(
        //   fontFamily: 'RobotoCondensed',
        //   fontSize: 24,
        //   fontWeight: FontWeight.bold,
        // ),
      ),
      onTap: tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          buildListTile(
            'Settings',
            Icons.settings,
            () {
              // Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          // buildListTile(
          //   'Last Orders',
          //   Icons.shopping_cart,
          //   () {
          //     // dynamic result = await _auth.singOut;
          //     // Navigator.of(context)
          //     //     .pushReplacementNamed(FilterScreen.routename);
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 26,
            ),
            title: Text(
              'Logout',
            ),
            onTap: () async {
              dynamic result = await _auth.singOut();
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new WelcomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}
