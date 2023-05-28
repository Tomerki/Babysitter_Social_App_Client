import 'dart:convert';

import 'package:baby_sitter/screens/filter_screen.dart';
import 'package:baby_sitter/widgets/babysitter_search_card.dart';
import 'package:baby_sitter/widgets/input_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../server_manager.dart';

Map<String, String> mapTextToFieldName = {
  'At your house': 'ComeToClient',
  'At her house': 'InMyPlace',
  'Takes to/from activities': 'TakesToActivities',
  'Knows how to cook': 'KnowsHowToCook',
  'First aid certified': 'FirstAidCertified',
  'Helping with housework': 'HelpingWithHouseWork',
  'Has a driver\'s license': 'HasDriverLicense',
  'Change a diaper': 'ChangeADiaper',
  'Has past experience': 'HasPastExperience',
  'Has an education in education': 'HasAnEducationInEducation',
};

class BabysitterSearchScreen extends StatefulWidget {
  const BabysitterSearchScreen({super.key});
  static final routeName = 'BabysitterSearchScreen';

  @override
  State<BabysitterSearchScreen> createState() => _BabysitterSearchScreenState();
}

class _BabysitterSearchScreenState extends State<BabysitterSearchScreen> {
  Future<List<dynamic>>? babysittersFuture;

  Map<String, String> currentAdditionsFilters = {};
  callback(Map<String, bool> booleanFilters, RangeValues priceValues) {
    double startPrice = priceValues.start;
    double endPrice = priceValues.end;

    setState(() {
      Map<String, String> transformedFilters = {};
      booleanFilters.forEach((key, value) {
        if (value) {
          transformedFilters[mapTextToFieldName[key]!] = value.toString();
        }
      });
      currentAdditionsFilters = transformedFilters;
      currentAdditionsFilters['endPrice_lte'] = priceValues.end.toString();
      currentAdditionsFilters['startPrice_gte'] = priceValues.start.toString();
      babysittersFuture = fetchBabysittersByBooleansAndPrice();
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   babysittersFuture = fetchBabysittersByBooleans();
  // }

  // Future<List<dynamic>> fetchBabysittersByName() async {
  //   final response = await ServerManager().getRequest('items', 'Babysitter');
  //   final decodedBody = json.decode(response.body);
  //   return decodedBody;
  // }

  // Future<List<dynamic>> fetchBabysittersByName() async {
  //   final response = await ServerManager()
  //       .getRequest('search_contain/fullName/' + 'c', 'Babysitter');
  //   final decodedBody = json.decode(response.body);
  //   return decodedBody;
  // }

  // Future<List<dynamic>> fetchBabysittersByBooleans() async {
  //   final response = await ServerManager().getRequestwithManyParams(
  //       'search_multiple', 'Babysitter', currentAdditionsFilters);
  //   print(response.body);
  //   final decodedBody = json.decode(response.body);
  //   return decodedBody;
  // }

  Future<List<dynamic>> fetchBabysittersByBooleansAndPrice() async {
    final response = await ServerManager().getRequestwithManyParams(
        'search_multiple2', 'Babysitter', currentAdditionsFilters);
    print(response.body);
    final decodedBody = json.decode(response.body);
    return decodedBody;
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Search for babysitter'),
    //     centerTitle: true,
    //     backgroundColor: Color.fromARGB(255, 219, 163, 154),
    //   ),
    //   body:
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(188, 227, 183, 160),
            Color.fromARGB(255, 236, 232, 217),
            Color.fromARGB(255, 250, 246, 233),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: queryData.size.width * 0.8,
                  child: InputBox(
                    keyType: TextInputType.name,
                    text: "Enter a name",
                    validator: () {},
                    onChanged: () {},
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => new FilterScreen(
                                  callback: callback,
                                )));
                  },
                  icon: Icon(Icons.tune),
                  iconSize: 32,
                ),
              ],
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: babysittersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the future to complete, show a progress indicator
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If there's an error, display an error message
                return Text('Error: ${snapshot.error}');
              } else {
                // Once the future completes successfully, render the list
                List? babysitters = snapshot.data;
                return Column(
                  children: babysitters != null
                      ? babysitters.reversed.map((babysitter) {
                          return BabysitterSearchCard(
                              imageUrl: 'bla',
                              babysitter_email: babysitter['email'],
                              babysitter_name: babysitter['firstName'] +
                                  ' ' +
                                  babysitter['lastName']);
                        }).toList()
                      : [Text('No Posts Yet')],
                );
              }
            },
          ),
        ],
      ),
      // ),
    );
  }
}
