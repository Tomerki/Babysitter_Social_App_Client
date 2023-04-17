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
  List recommendations = [];

  callback(List newRecommendations) {
    setState(() {
      recommendations = newRecommendations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations:'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NewRecommendation(
                  callback: callback,
                ),
                ...recommendations.reversed.map(
                  (a_recommendation) {
                    return RecommendationPost(
                      recommendation: a_recommendation,
                      hide: false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
