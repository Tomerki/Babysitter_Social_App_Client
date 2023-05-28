import 'dart:convert';

import 'package:baby_sitter/screens/babysitter_profile_screen.dart';
import 'package:baby_sitter/screens/filter_screen.dart';
import 'package:flutter/material.dart';

import '../server_manager.dart';

class BabysitterSearchCard extends StatefulWidget {
  final String babysitter_email;
  final String babysitter_name;
  final String imageUrl;
  const BabysitterSearchCard({
    super.key,
    required this.imageUrl,
    required this.babysitter_email,
    required this.babysitter_name,
  });

  @override
  State<BabysitterSearchCard> createState() => _BabysitterSearchCardState();
}

class _BabysitterSearchCardState extends State<BabysitterSearchCard> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: mediaQuery.size.width * .02,
        vertical: 4,
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () async {
          await ServerManager()
              .getRequest(
                  'search/email/' + widget.babysitter_email, 'Babysitter')
              .then((user) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => new BabysitterProfileScreen(
                          user_body: user.body,
                        )));
          });
        },
        child: ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text(widget.babysitter_name),
          trailing: Icon(
            Icons.arrow_right_sharp,
            size: 26,
          ),
        ),
      ),
    );
  }
}
