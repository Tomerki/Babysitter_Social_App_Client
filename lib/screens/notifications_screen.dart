import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationScreen extends StatelessWidget {
  static final routeName = 'NotificationScreen';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationWidget(notification: notifications[index]);
        },
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final AppNotification notification;

  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.notifications),
      title: Text(notification.title),
      subtitle: Text(notification.message),
      onTap: () {
        // Handle notification tap
        // You can navigate to a specific page or perform any action here
      },
    );
  }
}
