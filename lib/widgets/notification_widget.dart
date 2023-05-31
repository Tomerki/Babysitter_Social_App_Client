import 'package:flutter/material.dart';
import '../models/notification.dart';
import '../screens/babysitter_profile_screen.dart';
import '../server_manager.dart';

class NotificationWidget extends StatelessWidget {
  final notification;

  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.notifications),
      title: Text(notification["title"]),
      subtitle: Text(notification["massage"]),
      onTap: () async {
        await ServerManager()
            .getRequest('items/' + notification["babysitter_id"], 'Babysitter')
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
    );
  }
}
