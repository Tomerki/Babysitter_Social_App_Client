import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/appUser.dart';
import '../models/notification.dart';
import '../screens/babysitter_profile_screen.dart';
import '../server_manager.dart';

class NotificationWidget extends StatefulWidget {
  final notification;

  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool first_tap = false;

  Future<bool> fetch_tap() async {
    final response = await ServerManager().getRequest(
        'get_inner_item_collection/' +
            AppUser.getUid() +
            '/' +
            (widget.notification)['doc_id'] +
            '/notification',
        AppUser.getUserType());
    final decodedBody = json.decode(response.body);
    return decodedBody['was_tap'];
  }

  void _loadIsTap() {
    fetch_tap().then((value) {
      setState(() {
        first_tap = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetch_tap().then((value) {
      first_tap = value;
      setState(() {
        first_tap = value;
      });
    });

    _loadIsTap();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.notifications),
      title: Text(widget.notification["title"]),
      subtitle: Text(widget.notification["massage"]),
      trailing: first_tap ? Icon(Icons.done) : SizedBox(),
      onTap: () async {
        // await ServerManager()
        //     .getRequest(
        //         'items/' + widget.notification["babysitter_id"], 'Babysitter')
        //     .then((user) {
        //   Navigator.push(
        //       context,
        //       new MaterialPageRoute(
        //           fullscreenDialog: true,
        //           builder: (context) => new BabysitterProfileScreen(
        //                 user_body: user.body,
        //               )));
        // });
        if (!first_tap) {
          (widget.notification)['was_tap'] = true;
          await ServerManager().putRequest(
              'put_inner_item_collection/' +
                  AppUser.getUid() +
                  '/' +
                  (widget.notification)['doc_id'] +
                  '/notification',
              AppUser.getUserType(),
              body: jsonEncode(widget.notification));
          setState(() {
            first_tap = true;
          });
        }
      },
    );
  }
}
