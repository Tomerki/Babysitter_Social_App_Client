import 'package:baby_sitter/widgets/new_recommendation.dart';
import 'package:baby_sitter/widgets/recommendation_post.dart';
import 'package:flutter/material.dart';

class BabysitterRecommendationScreen extends StatefulWidget {
  static final routeName = 'BabysitterRecommendationScreen';

  @override
  State<BabysitterRecommendationScreen> createState() =>
      _BabysitterRecommendationScreenState();
}

class _BabysitterRecommendationScreenState
    extends State<BabysitterRecommendationScreen> {
  final _formKey = GlobalKey<FormState>();
  String recommendationValue = '';
  List recommendations = [];

  callback(List newRecommendations) {
    setState(() {
      recommendations = newRecommendations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Recommendations:'),
      //   centerTitle: true,
      //   backgroundColor: Color.fromARGB(255, 219, 163, 154),
      // ),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // NewRecommendation(
                //   callback: callback,
                // ),
                ...recommendations.reversed.map(
                  (a_recommendation) {
                    return RecommendationPost(
                      recommendation: a_recommendation,
                      hide: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
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
                          child: Text("Submit"),
                          onPressed: () async {
                            // setState(
                            //   () {
                            //     recommendations.add({
                            //       "description": recommendationValue,
                            //     });
                            //   },
                            // );
                            // callback(recommendations);
                            // Navigator.of(context, rootNavigator: true).pop();
                          }),
                    ],
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(66, 106, 112, 113),
      ),
    );
  }
}
