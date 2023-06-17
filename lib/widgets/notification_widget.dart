import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../models/appUser.dart';
import '../screens/babysitter_screens/babysitter_profile_screen.dart';
import '../screens/chat_page_screen.dart';
import '../server_manager.dart';
import '../services/auth.dart';

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
      title: Text(
        widget.notification["title"],
        style: GoogleFonts.workSans(
          textStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ),
      subtitle: Text(
        widget.notification["massage"],
        style: GoogleFonts.workSans(
          textStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
      ),
      trailing: first_tap ? Icon(Icons.done) : SizedBox(),
      onTap: () async {
        if (widget.notification["type"] == "job bell") {
          await ServerManager()
              .getRequest(
                  'items/' + widget.notification["babysitter_id"], 'Babysitter')
              .then((user) {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: BabysitterProfileScreen(
                user_body: user.body,
              ),
              withNavBar: false,
            );
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
                      title: Text(
                        'new recommendation from: ' +
                            json.decode(value.body)['parent_fullName'],
                        style: GoogleFonts.workSans(
                          color: Colors.black,
                          textStyle: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      content: Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            json.decode(value.body)['description'],
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            "Confirm",
                            style: GoogleFonts.workSans(
                              color: Colors.blue,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
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
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.workSans(
                              color: Color.fromARGB(255, 81, 26, 26)
                                  .withOpacity(0.8),
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final put_body = json.decode(value.body);
                            put_body['is_confirmed'] = false;
                            await ServerManager().putRequest(
                              'put_inner_item_collection/' +
                                  AppUser.getUid() +
                                  '/' +
                                  (widget.notification)['recommendation_id'] +
                                  '/recommendation',
                              AppUser.getUserType(),
                              body: jsonEncode(put_body),
                            );
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          });
        } else if (widget.notification["type"] == "new job request") {
          await ServerManager()
              .getRequest(
                  'get_inner_item_collection/' +
                      AppUser.getUid() +
                      '/' +
                      (widget.notification)['jobRequest_id'] +
                      '/jobRequest',
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
                      title: Text(
                        'Details about the job:',
                        style: GoogleFonts.workSans(
                          color: Colors.black,
                          textStyle: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      content: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Job date: ',
                                    style: GoogleFonts.workSans(
                                      color: Colors.black,
                                      textStyle: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${json.decode(value.body)['date']}'
                                        .substring(0, 10),
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
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Hours: ',
                                    style: GoogleFonts.workSans(
                                      color: Colors.black,
                                      textStyle: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${json.decode(value.body)['startHour']} - ${json.decode(value.body)['endHour']}',
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
                              ),
                              Row(
                                children: [
                                  Text(
                                    'description: ',
                                    style: GoogleFonts.workSans(
                                      color: Colors.black,
                                      textStyle: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${json.decode(value.body)['description']}',
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                child: Text(
                                  'chat with the parent',
                                  style: GoogleFonts.workSans(
                                    color: Colors.blue,
                                    textStyle: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  await ServerManager()
                                      .getRequest(
                                          'items/' +
                                              widget.notification["parent_id"],
                                          'Parent')
                                      .then((user) async {
                                    await AuthService.addChatUser(
                                            json.decode(user.body)['email'])
                                        .then((value) {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: ChatPageScreen(
                                            secondUid:
                                                json.decode(user.body)['uid'],
                                            chatId: value,
                                            secondUserType: 'Parent',
                                          ));
                                    });
                                  });
                                }),
                            TextButton(
                                child: Text(
                                  "Close",
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
                        ),
                      ],
                    );
                  },
                );
              },
            );
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
