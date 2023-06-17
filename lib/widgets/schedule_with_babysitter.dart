import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../server_manager.dart';

class ScheduleWithaBysitter extends StatefulWidget {
  String parentId;
  String user_body;
  ScheduleWithaBysitter(
      {super.key, required this.user_body, required this.parentId});

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
      child: Text(
        "Click here to schedule with the babysitter",
        style: GoogleFonts.workSans(
          color: Colors.white,
          textStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.black.withOpacity(0.8),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                  title: Text(
                    'New Job',
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
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
                            label: Text(
                              'Pick a date',
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
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
                            label: Text(
                              'Pick time',
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
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
                          Text(
                            '${selectedDate.toString().substring(0, 10)}\n from: ${startTime}\nUntil: ${endTime}\n',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Divider(),
                          Divider(),
                          Text(
                            'job description:',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: TextField(
                                maxLines: 8,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Enter your text here"),
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
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
                      child: Text(
                        "Submit",
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
                                    'parent_id': widget.parentId,
                                  },
                                ));
                          },
                        );
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.workSans(
                          color:
                              Color.fromARGB(255, 81, 26, 26).withOpacity(0.8),
                          textStyle: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
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
