import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/appUser.dart';
import '../models/notification.dart';
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

  final List<AppNotification> notifications = [
    AppNotification(
      title: 'New Message',
      message: 'You have a new message from John.',
    ),
    AppNotification(
      title: 'Friend Request',
      message: 'You received a friend request from Lisa.',
    ),
    AppNotification(
      title: 'Reminder',
      message: 'Don\'t forget to attend the meeting at 3 PM.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<dynamic>>(
        future: notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the future to complete, show a progress indicator
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            // Once the future completes successfully, render the list
            List? notifications = snapshot.data;
            return Column(
              children: notifications != null && !notifications.isEmpty
                  ? (notifications.map((notification) {
                      print(notification);
                      return NotificationWidget(
                        notification: notification,
                      );
                    }).toList())
                  : [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('No Notifications Yet'),
                      )
                    ],
            );
          }
        },
      ),
    );
    // ListView.builder(
    //   itemCount: notifications.length,
    //   itemBuilder: (context, index) {
    //     return NotificationWidget(notification: notifications[index]);
    //   },
    // );
  }
}
