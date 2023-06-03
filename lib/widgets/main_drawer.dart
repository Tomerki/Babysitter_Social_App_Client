import 'package:baby_sitter/models/appUser.dart';
import 'package:baby_sitter/screens/edit_babysitter_profile_screen.dart';
import 'package:baby_sitter/screens/filter_screen.dart';
import 'package:baby_sitter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../screens/wrapper.dart';
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
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
            ),
            title: Text(
              'Settings',
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditBabysitterProfileScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 26,
            ),
            title: Text(
              'Logout',
            ),
            onTap: () async {
              AppUser.deleteInstance();
              await _auth.singOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}
