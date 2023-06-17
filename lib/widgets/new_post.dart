import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import '../server_manager.dart';
import 'custom_widgets/circle_button_one.dart';

class NewPost extends StatefulWidget {
  Function(List jobs) callback;
  String publisherName;
  String parentId;
  NewPost(
      {super.key,
      required this.callback,
      required this.publisherName,
      required this.parentId});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final currentDate = DateTime.now();
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
  List jobs = [];

  @override
  Widget build(BuildContext context) {
    startTime = TimeOfDay(hour: 9, minute: 0).format(context);
    endTime = TimeOfDay(hour: 00, minute: 0).format(context);
    selectedDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day + 1,
    );

    return ElevatedButton(
      child: Text(
        'Click to add a new job',
        style: GoogleFonts.workSans(
          color: Colors.white,
          textStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                            '${selectedDate.toString().substring(0, 10)}\nfrom: ${startTime}\nUntil: ${endTime}\n',
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
                                        style: GoogleFonts.workSans(
                                          color: Colors.black,
                                          textStyle: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
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
                                      style: GoogleFonts.workSans(
                                        color: Colors.black,
                                        textStyle: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Select Age",
                                          style: GoogleFonts.workSans(
                                            color: Colors.black,
                                            textStyle: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
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
                                    style: GoogleFonts.workSans(
                                      color: Colors.black,
                                      textStyle: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
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
                          Text(
                            'job description:',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
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
                                  hintText: "Enter your text here",
                                ),
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
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        await ServerManager.checkLanguage(jobDescription).then(
                          (value) async {
                            if (!value) {
                              await serverManager
                                  .postRequest(
                                'add_doc',
                                'Jobs',
                                body: jsonEncode(
                                  {
                                    "publisher": widget.publisherName,
                                    "parent_id": widget.parentId,
                                    "date": selectedDate.toString(),
                                    "startHour": startTime,
                                    "endHour": endTime,
                                    "childrens": children,
                                    "description": jobDescription,
                                  },
                                ),
                              )
                                  .then(
                                (response) async {
                                  serverManager
                                      .getRequest(
                                    'items',
                                    'Jobs',
                                  )
                                      .then((newList) {
                                    jobs = json.decode(newList.body);
                                    widget.callback(jobs);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  });
                                },
                              );
                            } else {
                              Navigator.of(context, rootNavigator: true).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 122, 25, 18),
                                  behavior: SnackBarBehavior.floating,
                                  elevation: 5,
                                  content: Text(
                                    "Please use an appropriate language!",
                                    style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      textStyle: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                        );
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
