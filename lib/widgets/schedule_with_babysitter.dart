import 'dart:convert';
import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import '../server_manager.dart';
import '../widgets/circle_button_one.dart';

class ScheduleWithaBysitter extends StatefulWidget {
  // Function(List jobs) callback;
  // String publisherName;
  String parentId;
  String user_body;
  ScheduleWithaBysitter(
      {super.key,
      // required this.callback,
      required this.user_body,
      // required this.publisherName,
      required this.parentId});

  @override
  State<ScheduleWithaBysitter> createState() => _ScheduleWithaBysitterState();
}

class _ScheduleWithaBysitterState extends State<ScheduleWithaBysitter> {
  final currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final serverManager = ServerManager();

  String startTime = '';
  String endTime = '';
  String childGender = 'male';
  final bool showNumberPicker = false;
  int childAge = 0;
  bool addChild = false;
  DateTime selectedDate = DateTime.now();
  String jobDescription = '';
  List jobs = [];

  @override
  Widget build(BuildContext context) {
    var decoded_user_body = json.decode(widget.user_body);
    startTime = TimeOfDay(hour: 9, minute: 0).format(context);
    endTime = TimeOfDay(hour: 00, minute: 0).format(context);
    selectedDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day + 1,
    );
    return ElevatedButton(
      child: Text("Click here to schedule with the babysitter"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 51, 65, 78),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  scrollable: true,
                  title: Text('New Job'),
                  content: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          ElevatedButton.icon(
                            style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(
                                Colors.black,
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.transparent,
                              ),
                              enableFeedback: true,
                            ),
                            label: Text('Pick a date'),
                            icon: Icon(Icons.date_range),
                            onPressed: () async {
                              await showDatePicker(
                                context: context,
                                initialDate: currentDate,
                                firstDate: currentDate,
                                lastDate: DateTime(
                                  currentDate.year,
                                  currentDate.month + 3,
                                  currentDate.day,
                                ),
                              ).then((value) => {
                                    setState(
                                      () {
                                        selectedDate = value!;
                                      },
                                    )
                                  });
                            },
                          ),
                          ElevatedButton.icon(
                            style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(
                                Colors.black,
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.transparent,
                              ),
                              enableFeedback: true,
                            ),
                            label: Text('Pick time'),
                            icon: Icon(Icons.timer),
                            onPressed: () async {
                              await showTimeRangePicker(
                                context: context,
                                start: const TimeOfDay(hour: 9, minute: 0),
                                end: const TimeOfDay(hour: 12, minute: 0),
                                strokeWidth: 4,
                                ticks: 24,
                                ticksOffset: -7,
                                ticksLength: 15,
                                ticksColor: Colors.grey,
                                labels: [
                                  "12 am",
                                  "3 am",
                                  "6 am",
                                  "9 am",
                                  "12 pm",
                                  "3 pm",
                                  "6 pm",
                                  "9 pm"
                                ].asMap().entries.map((e) {
                                  return ClockLabel.fromIndex(
                                      idx: e.key, length: 8, text: e.value);
                                }).toList(),
                                labelOffset: 35,
                                rotateLabels: false,
                                padding: 60,
                                onStartChange: (p0) {
                                  setState(() {
                                    startTime = p0.format(context);
                                  });
                                },
                                onEndChange: (p0) {
                                  setState(() {
                                    endTime = p0.format(context);
                                  });
                                },
                              );
                            },
                          ),
                          // startTime != '' && endTime != '' && selectedDate != ''
                          //     ?
                          Text(
                              '${selectedDate}\n from: ${startTime}\nUntil: ${endTime}\n'),
                          // : Text('No hours/day selected yet'),
                          Divider(),
                          Divider(),
                          Text('job description:'),
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: TextField(
                                maxLines: 8,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Enter your text here"),
                                style: TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      jobDescription = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text("Submit"),
                      onPressed: () async {
                        await ServerManager()
                            .postRequest(
                                'add_inner_collection/' +
                                    decoded_user_body['uid'] +
                                    '/jobRequest',
                                'Babysitter',
                                body: jsonEncode(
                                  {
                                    "babysitter_id": decoded_user_body['uid'],
                                    "date": selectedDate.toString(),
                                    "startHour": startTime,
                                    "endHour": endTime,
                                    "description": jobDescription,
                                    'parent_id': widget.parentId,
                                  },
                                ))
                            .then(
                          (value) async {
                            await ServerManager().postRequest(
                                'add_inner_collection/' +
                                    decoded_user_body['uid'] +
                                    '/notification',
                                'Babysitter',
                                body: jsonEncode(
                                  {
                                    'title': "A parent wants Schedule with you",
                                    'massage': "Click to see more details",
                                    'jobRequest_id':
                                        json.decode(value.body)['id'],
                                    'was_tap': false,
                                    'type': 'new job request',
                                  },
                                ));
                          },
                        );
                        Navigator.of(context, rootNavigator: true).pop();
                      },

                      // onPressed: () async {
                      //   await serverManager
                      //       .postRequest(
                      //     'add_doc',
                      //     'Jobs',
                      //     body: jsonEncode(
                      //       {
                      //         "publisher": widget.publisherName,
                      //         "parent_id": widget.parentId,
                      //         "date": selectedDate.toString(),
                      //         "startHour": startTime,
                      //         "endHour": endTime,
                      //         "childrens": children,
                      //         "description": jobDescription,
                      //       },
                      //     ),
                      //   )
                      //       .then((response) async {
                      //     serverManager
                      //         .getRequest(
                      //       'items',
                      //       'Jobs',
                      //     )
                      //         .then((newList) {
                      //       jobs = json.decode(newList.body);
                      //       widget.callback(jobs);
                      //       Navigator.of(context, rootNavigator: true).pop();
                      //     });
                      //   });
                      // },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
