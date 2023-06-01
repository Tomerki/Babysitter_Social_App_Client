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
        if (widget.notification["type"] == "job bell") {
          await ServerManager()
              .getRequest(
                  'items/' + widget.notification["babysitter_id"], 'Babysitter')
              .then((user) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => new BabysitterProfileScreen(
                          user_body: user.body,
                        )));
          });
        } else if (widget.notification["type"] == "new recommendation") {
          await ServerManager()
              .getRequest(
                  'get_inner_item_collection/' +
                      AppUser.getUid() +
                      '/' +
                      (widget.notification)['recommendation_id'] +
                      '/recommendation',
                  AppUser.getUserType())
              .then((value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                      scrollable: true,
                      title: Text('new recommendation from: ' +
                          json.decode(value.body)['parent_fullName']),
                      content: Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(json.decode(value.body)['description']),
                        ),
                      ),
                      actions: [
                        TextButton(
                            child: Text("confirm"),
                            onPressed: () async {
                              final put_body = json.decode(value.body);
                              put_body['is_confirmed'] = true;
                              await ServerManager().putRequest(
                                'put_inner_item_collection/' +
                                    AppUser.getUid() +
                                    '/' +
                                    (widget.notification)['recommendation_id'] +
                                    '/recommendation',
                                AppUser.getUserType(),
                                body: jsonEncode(put_body),
                              );
                              // widget.callback(recommendations);
                              Navigator.of(context, rootNavigator: true).pop();
                            }),
                      ],
                    );
                  },
                );
              },
            );
            print(json.decode(value.body)['created']);
          });
        }

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
