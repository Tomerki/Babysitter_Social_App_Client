import 'dart:convert';
import 'package:baby_sitter/models/appUser.dart';
import 'package:baby_sitter/models/sharedPreferencesHelper.dart';
import '../screens/babysitter_screens/edit_babysitter_profile_screen.dart';
import '../screens/parent_screens/edit_parent_screen.dart';
import 'package:baby_sitter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../server_manager.dart';
import '../services/auth.dart';

class MainDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  MainDrawer({super.key});

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
              style: GoogleFonts.workSans(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            onTap: () async {
              AppUser.getUserKind()
                  ? await ServerManager()
                      .getRequest('items/' + AppUser.getUid(), 'Babysitter')
                      .then((value) {
                      final babysitter = json.decode(value.body);
                      Map<String, bool> texts = {
                        'Come to client':
                            babysitter['ComeToClient'] == 'true' ? true : false,
                        'In my place':
                            babysitter['InMyPlace'] == 'true' ? true : false,
                        'Takes to/from activities':
                            babysitter['TakesToActivities'] == 'true'
                                ? true
                                : false,
                        'Knows how to cook':
                            babysitter['KnowsHowToCook'] == 'true'
                                ? true
                                : false,
                        'First aid certified':
                            babysitter['FirstAidCertified'] == 'true'
                                ? true
                                : false,
                        'Helping with housework':
                            babysitter['HelpingWithHouseWork'] == 'true'
                                ? true
                                : false,
                        'Has a driver\'s license':
                            babysitter['HasDriverLicense'] == 'true'
                                ? true
                                : false,
                        'Change a diaper': babysitter['ChangeADiaper'] == 'true'
                            ? true
                            : false,
                        'Has past experience':
                            babysitter['HasPastExperience'] == 'true'
                                ? true
                                : false,
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
                                    image: babysitter['image'],
                                    address: babysitter['address'],
                                  )));
                    })
                  : await ServerManager()
                      .getRequest('items/' + AppUser.getUid(), 'Parent')
                      .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditParentProfileScreen(
                                    image: json.decode(value.body)['image'],
                                    address: json.decode(value.body)['address'],
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
              style: GoogleFonts.workSans(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () async {
              SharedPreferencesHelper.clearLoggedInUser();
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
