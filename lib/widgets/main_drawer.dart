import 'dart:convert';

import 'package:baby_sitter/models/appUser.dart';
import 'package:baby_sitter/screens/edit_babysitter_profile_screen.dart';
import 'package:baby_sitter/screens/filter_screen.dart';
import 'package:baby_sitter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../screens/wrapper.dart';
import '../server_manager.dart';
import '../services/auth.dart';

class MainDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  MainDrawer({super.key});
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
              await ServerManager()
                  .getRequest('items/' + AppUser.getUid(), 'Babysitter')
                  .then((value) {
                final babysitter = json.decode(value.body);
                Map<String, bool> texts = {
                  'Come to client':
                      babysitter['ComeToClient'] == 'true' ? true : false,
                  'In my place':
                      babysitter['InMyPlace'] == 'true' ? true : false,
                  'Takes to/from activities':
                      babysitter['TakesToActivities'] == 'true' ? true : false,
                  'Knows how to cook':
                      babysitter['KnowsHowToCook'] == 'true' ? true : false,
                  'First aid certified':
                      babysitter['FirstAidCertified'] == 'true' ? true : false,
                  'Helping with housework':
                      babysitter['HelpingWithHouseWork'] == 'true'
                          ? true
                          : false,
                  'Has a driver\'s license':
                      babysitter['HasDriverLicense'] == 'true' ? true : false,
                  'Change a diaper':
                      babysitter['ChangeADiaper'] == 'true' ? true : false,
                  'Has past experience':
                      babysitter['HasPastExperience'] == 'true' ? true : false,
                  'Has an education in education':
                      babysitter['HasAnEducationInEducation'] == 'true'
                          ? true
                          : false,
                };
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditBabysitterProfileScreen(
                              texts: texts,
                              about: babysitter['about'],
                              price: babysitter['price'],
                              age: babysitter['age'],
                            )));
              });
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
