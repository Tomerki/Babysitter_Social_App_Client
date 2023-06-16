import 'dart:convert';

import 'package:baby_sitter/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/appUser.dart';
import '../server_manager.dart';
import '../widgets/notification_widget.dart';

class NotificationScreen extends StatefulWidget {
  static final routeName = 'NotificationScreen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final String userType = AppUser.getUserType();
  Future<List<dynamic>>? notificationsFuture;

  @override
  void initState() {
    super.initState();
    notificationsFuture = fetchNotifications();
  }

  Future<List<dynamic>> fetchNotifications() async {
    final response = await ServerManager().getRequest(
        'get_inner_collection/' + AppUser.getUid() + '/notification',
        AppUser.getUserType());
    final decodedBody = json.decode(response.body);
    return decodedBody;
  }

  void updateNotifications(List<dynamic> newJobs) {
    setState(() {
      notificationsFuture = Future.value(newJobs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<List<dynamic>>(
            future: notificationsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the future to complete, show a progress indicator
                return Loading();
              } else if (snapshot.hasError) {
                // If there's an error, display an error message
                return Text('Error: ${snapshot.error}');
              } else {
                // Once the future completes successfully, render the list
                List? notifications = snapshot.data;
                return Column(
                  children: notifications != null && !notifications.isEmpty
                      ? (notifications.map((notification) {
                          return NotificationWidget(
                            notification: notification,
                          );
                        }).toList())
                      : [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'No Notifications Yet',
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
