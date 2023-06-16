import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_widgets/circle_button_two.dart';

class NewRecommendation extends StatefulWidget {
  Function(List jobs) callback;
  NewRecommendation({super.key, required this.callback});

  @override
  State<NewRecommendation> createState() => _NewRecommendationState();
}

class _NewRecommendationState extends State<NewRecommendation> {
  final _formKey = GlobalKey<FormState>();
  String recommendationValue = '';
  final List recommendations = [];
  @override
  Widget build(BuildContext context) {
    return CircleButtonTwo(
      text: 'Click to add a new recommendation!',
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
                  title: Text('New Recommendation'),
                  content: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
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
                                      recommendationValue = value;
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
                        onPressed: () {
                          setState(
                            () {
                              recommendations.add({
                                "description": recommendationValue,
                              });
                            },
                          );
                          widget.callback(recommendations);
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
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
