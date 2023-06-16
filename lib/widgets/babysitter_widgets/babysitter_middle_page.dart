import 'dart:convert';

import 'package:baby_sitter/server_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BabysitterMiddlePage extends StatelessWidget {
  final double pageHight;
  final double pagewidth;
  final String price;
  final String user_body;

  const BabysitterMiddlePage(
      {super.key,
      required this.pageHight,
      required this.pagewidth,
      required this.price,
      required this.user_body});

  @override
  Widget build(BuildContext context) {
    var decoded_user_body = json.decode(user_body);
    return Container(
      height: pageHight,
      width: pagewidth * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              color: Color.fromARGB(200, 129, 91, 91),
              elevation: 5,
              child: Center(
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payment_sharp,
                        size: 40,
                      ),
                    ],
                  ),
                  title: Text(
                    '${price}',
                    style: GoogleFonts.workSans(
                      color: Colors.white70,
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'Hourly Rate',
                    style: GoogleFonts.workSans(
                      color: Colors.white70,
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              elevation: 5,
              color: Color.fromARGB(200, 129, 91, 91),
              child: InkWell(
                onTap: () async {
                  await ServerManager()
                      .getRequest(
                          'items/' + decoded_user_body['uid'], 'Babysitter')
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
                          babysitter['KnowsHowToCook'] == 'true' ? true : false,
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
                      'Change a diaper':
                          babysitter['ChangeADiaper'] == 'true' ? true : false,
                      'Has past experience':
                          babysitter['HasPastExperience'] == 'true'
                              ? true
                              : false,
                      'Has an education in education':
                          babysitter['HasAnEducationInEducation'] == 'true'
                              ? true
                              : false,
                    };
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 40),
                              scrollable: true,
                              title: Text(
                                'Babysitter Skills:',
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              content: Column(
                                children: [
                                  ...texts.keys.map(
                                    (key) {
                                      return Row(
                                        children: [
                                          texts[key] == true
                                              ? Icon(Icons.done_sharp)
                                              : Icon(Icons.cancel_sharp),
                                          Text(
                                            key,
                                            style: GoogleFonts.workSans(
                                              color: Colors.black,
                                              textStyle: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    child: Text(
                                      "close",
                                      style: GoogleFonts.workSans(
                                        color: Color.fromARGB(255, 81, 26, 26)
                                            .withOpacity(0.8),
                                        textStyle: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    }),
                              ],
                            );
                          },
                        );
                      },
                    );
                  });
                },
                child: Center(
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.join_inner_sharp,
                          size: 40,
                        ),
                      ],
                    ),
                    title: Text(
                      'Click',
                      style: GoogleFonts.workSans(
                        color: Colors.white70,
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      'For more details',
                      style: GoogleFonts.workSans(
                        color: Colors.white70,
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
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
