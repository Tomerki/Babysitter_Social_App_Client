import 'dart:convert';

import 'package:baby_sitter/widgets/loading.dart';
import 'package:baby_sitter/widgets/recommendation_post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/appUser.dart';
import '../../server_manager.dart';

class BabysitterRecommendationScreen extends StatefulWidget {
  static final routeName = 'BabysitterRecommendationScreen';
  final String babysitter_id;

  const BabysitterRecommendationScreen(
      {super.key, required this.babysitter_id});

  @override
  State<BabysitterRecommendationScreen> createState() =>
      _BabysitterRecommendationScreenState();
}

class _BabysitterRecommendationScreenState
    extends State<BabysitterRecommendationScreen> {
  final _formKey = GlobalKey<FormState>();
  String recommendationValue = '';
  String parentNameValue = '';
  List recommendations = [];
  Future<List<dynamic>>? recommendationsFuture;

  @override
  void initState() {
    super.initState();
    recommendationsFuture = fetchRecommendations();
  }

  @override
  void didChangeDependencies() {
    recommendationsFuture = fetchRecommendations();
    super.didChangeDependencies();
  }

  Future<List<dynamic>> fetchRecommendations() async {
    var result;
    Map<String, String> is_confirmed_map = {"is_confirmed": "true"};

    await ServerManager()
        .getRequestwithManyParams(
            'get_filter_inner_collection/' +
                widget.babysitter_id +
                '/recommendation',
            'Babysitter',
            is_confirmed_map)
        .then((value) {
      result = json.decode(value.body);
    });

    return result;
  }

  void updateRecommendations() {
    setState(() {
      recommendationsFuture = Future.value(fetchRecommendations());
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    bool showFloatingActionButton = !AppUser.getUserKind();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Recommendations',
          style: GoogleFonts.workSans(
            color: Colors.black,
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 129, 100, 110).withOpacity(0.2),
        elevation: 5.0,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                fit: BoxFit.cover,
                opacity: 0.3)),
        child: FutureBuilder<List<dynamic>>(
          future: recommendationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the future to complete, show a progress indicator
              return Loading();
            } else if (snapshot.hasError) {
              // If there's an error, display an error message
              return Text('Error: ${snapshot.error}');
            } else {
              // Once the future completes successfully, render the list
              List? recommendations = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children:
                      (recommendations != null && recommendations.isNotEmpty)
                          ? recommendations.map((recommendation) {
                              return RecommendationPost(
                                recommendation: recommendation,
                                callback: updateRecommendations,
                                hide: true,
                              );
                            }).toList()
                          : [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'No Results',
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFloatingActionButton
          ? FloatingActionButton.large(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 40),
                          scrollable: true,
                          title: Text(
                            'New Recommendation',
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
                                  Card(
                                    child: Container(
                                      color: Colors.white70,
                                      child: TextField(
                                        decoration: InputDecoration.collapsed(
                                            hintText: "Enter your Name"),
                                        style: GoogleFonts.workSans(
                                          color: Colors.black,
                                          textStyle: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              parentNameValue = value;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 5,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: TextField(
                                        maxLines: 8,
                                        decoration: InputDecoration.collapsed(
                                            hintText: "Enter your text here"),
                                        style: GoogleFonts.workSans(
                                          color: Colors.black,
                                          textStyle: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
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
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                await ServerManager.checkLanguage(
                                        recommendationValue)
                                    .then(
                                  (value) async {
                                    if (!value) {
                                      await ServerManager()
                                          .postRequest(
                                              'add_inner_collection/' +
                                                  widget.babysitter_id +
                                                  '/recommendation',
                                              'Babysitter',
                                              body: jsonEncode(
                                                {
                                                  'babysitter_id':
                                                      widget.babysitter_id,
                                                  'description':
                                                      recommendationValue,
                                                  'is_confirmed': false,
                                                  'parent_id': AppUser.getUid(),
                                                  'parent_fullName':
                                                      parentNameValue.length ==
                                                              0
                                                          ? 'anonymous'
                                                          : parentNameValue,
                                                },
                                              ))
                                          .then(
                                        (value) async {
                                          await ServerManager().postRequest(
                                            'add_inner_collection/' +
                                                widget.babysitter_id +
                                                '/notification',
                                            'Babysitter',
                                            body: jsonEncode(
                                              {
                                                'title':
                                                    "A parent wants to publish a recommendation about you",
                                                'massage':
                                                    "Click to see the recommendation",
                                                'recommendation_id': json
                                                    .decode(value.body)['id'],
                                                'was_tap': false,
                                                'type': 'new recommendation',
                                              },
                                            ),
                                          );
                                        },
                                      );
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    } else {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          elevation: 5,
                                          content: Text(
                                            "Please Use with an appropriate language",
                                            style: TextStyle(color: Colors.red),
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
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
              backgroundColor: Color.fromARGB(66, 106, 112, 113),
            )
          : null,
    );
  }
}
