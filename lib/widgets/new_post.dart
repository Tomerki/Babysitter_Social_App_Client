import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import '../server_manager.dart';
import '../widgets/circle_button_one.dart';

class NewPost extends StatefulWidget {
  Function(List jobs) callback;
  NewPost({super.key, required this.callback});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _formKey = GlobalKey<FormState>();
  final serverManager = ServerManager();
  final List children = [];
  String startTime = '';
  String endTime = '';
  String childGender = 'male';
  final bool showNumberPicker = false;
  int childAge = 0;
  bool addChild = false;
  DateTime selectedDate = DateTime.now();
  String jobDescription = '';
  final List jobs = [];

  @override
  Widget build(BuildContext context) {
    return CircleButtonOne(
      text: 'Click to add a new job!',
      cWidth: 0.7,
      bgColor: Color.fromARGB(255, 219, 163, 154),
      textColor: Colors.white,
      handler: () {
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
                            onPressed: () {
                              final currentDate = DateTime.now();
                              showDatePicker(
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
                              TimeRange? result = await showTimeRangePicker(
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
                          startTime != '' || endTime != ''
                              ? Text('From: ${startTime}\nUntil: ${endTime}')
                              : Text('No hours selected yet'),
                          Divider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              for (var child in children)
                                Card(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${child["age"]} year old ${child["gender"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              children.remove(child);
                                            });
                                          })
                                    ],
                                  ),
                                )
                            ],
                          ),
                          if (addChild)
                            // For Adding Child
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Add Child",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Select Age",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17),
                                        ),
                                        NumberPicker(
                                            itemCount: 3,
                                            axis: Axis.vertical,
                                            minValue: 0,
                                            maxValue: 18,
                                            value: childAge,
                                            onChanged: (value) {
                                              setState(() {
                                                childAge = value;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CircleButtonOne(
                                          bgColor: childGender == "male"
                                              ? Colors.black
                                              : Colors.white,
                                          textColor: childGender == "male"
                                              ? Colors.white
                                              : Colors.black,
                                          cWidth: 0.25,
                                          text: "Male",
                                          handler: () {
                                            setState(() {
                                              childGender = "male";
                                            });
                                          },
                                          cPaddingBottom: 5,
                                          cPaddingRight: 5,
                                        ),
                                        CircleButtonOne(
                                          bgColor: childGender == "female"
                                              ? Colors.black
                                              : Colors.white,
                                          textColor: childGender == "female"
                                              ? Colors.white
                                              : Colors.black,
                                          cWidth: 0.25,
                                          text: "female",
                                          handler: () {
                                            setState(() {
                                              childGender = "female";
                                            });
                                          },
                                          cPaddingBottom: 5,
                                          cPaddingRight: 5,
                                        ),
                                      ],
                                    ),
                                    CircleButtonOne(
                                      textColor: Colors.white,
                                      bgColor: Colors.black,
                                      text: "Add Child",
                                      textSize: 15,
                                      cWidth: 0.25,
                                      handler: () {
                                        children.add({
                                          "gender": childGender,
                                          "age": childAge
                                        });
                                        setState(() {
                                          addChild = false;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          if (!addChild)
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Add Child",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          addChild = true;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                            ),
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
                      onPressed: () {
                        setState(
                          () {
                            jobs.add({
                              "date":
                                  DateFormat.yMMMMEEEEd().format(selectedDate),
                              "startHour": startTime,
                              "endHour": endTime,
                              "childrens": children,
                              "description": jobDescription,
                            });
                          },
                        );
                        serverManager
                            .postRequest(
                          'add_doc',
                          body: jsonEncode(
                            {
                              "date": selectedDate.toString(),
                              "startHour": startTime,
                              "endHour": endTime,
                              "childrens": children.toString(),
                              "description": jobDescription,
                            },
                          ),
                        )
                            .then((response) {
                          print(json.decode(response.body)['id']);
                        });
                        widget.callback(jobs);
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
