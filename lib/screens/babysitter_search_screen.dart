import 'dart:convert';

import 'package:baby_sitter/screens/filter_screen.dart';
import 'package:baby_sitter/widgets/babysitter_search_card.dart';
import 'package:baby_sitter/widgets/input_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
  String? name;
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
      babysittersFuture =
          fetchBabysittersByBooleansAndPrice(startPrice, endPrice);
    });
  }

  Future<List<dynamic>> fetchBabysittersByBooleansAndPrice(
      double startPrice, double endPrice) async {
    final response = await ServerManager().getRequestwithManyParams(
        'search_multiple/' + startPrice.toString() + '/' + endPrice.toString(),
        'Babysitter',
        currentAdditionsFilters);
    final decodedBody = json.decode(response.body);
    return decodedBody;
  }

  Future<List<dynamic>> fetchBabysittersByName() async {
    final response = await ServerManager()
        .getRequest('/search_contain/fullName/' + name!, 'Babysitter');
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
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
              fit: BoxFit.cover,
              opacity: 0.3)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: queryData.size.width * 0.7,
                  child: InputBox(
                    keyType: TextInputType.name,
                    text: "Enter a name",
                    validator: () {},
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                ),
                Container(
                  width: queryData.size.width * 0.1,
                  child: IconButton(
                    onPressed: () {
                      if (name != null && name!.length > 0) {
                        setState(() {
                          babysittersFuture = fetchBabysittersByName();
                        });
                      }
                    },
                    icon: Icon(Icons.search),
                    iconSize: 32,
                  ),
                ),
                Container(
                  width: queryData.size.width * 0.1,
                  child: IconButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        // settings: RouteSettings(name: FilterScreen.routeName),
                        screen: FilterScreen(
                          callback: callback,
                        ),
                        withNavBar: false,
                      );
                    },
                    icon: Icon(Icons.tune),
                    iconSize: 32,
                  ),
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
                  children: (babysitters != null && babysitters.isNotEmpty)
                      ? babysitters.reversed.map((babysitter) {
                          return BabysitterSearchCard(
                              imageUrl: 'bla',
                              babysitter_email: babysitter['email'],
                              babysitter_name: babysitter['firstName'] +
                                  ' ' +
                                  babysitter['lastName']);
                        }).toList()
                      : [
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
