import 'dart:convert';
import 'package:baby_sitter/models/appUser.dart';
import '../parent_screens/filter_screen.dart';
import 'package:baby_sitter/services/auth.dart';
import '../../widgets/babysitter_widgets/babysitter_search_card.dart';
import '../../widgets/custom_widgets/input_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../server_manager.dart';

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
  double startPrice = 0.0;
  double endPrice = 100.0;
  double minDis = 0.0;
  double maxDis = 50.0;
  Future<List<dynamic>>? babysittersFuture;
  Future<List<dynamic>>? babysittersFutureDisSort;
  String? name;
  Map<String, String> currentAdditionsFilters = {};
  bool ByName = true;
  callback(Map<String, bool> booleanFilters, RangeValues priceValues,
      RangeValues distanceValues) {
    double startPrice = priceValues.start;
    double endPrice = priceValues.end;

    setState(() {
      minDis = distanceValues.start;
      maxDis = distanceValues.end;
      ByName = false;
      name = null;
      Map<String, String> transformedFilters = {};
      booleanFilters.forEach((key, value) {
        if (value) {
          transformedFilters[mapTextToFieldName[key]!] = value.toString();
        }
      });
      currentAdditionsFilters = transformedFilters;
      babysittersFuture = fetchBabysittersByBooleansAndPriceAndDis(
          startPrice, endPrice, minDis, maxDis);
    });
  }

  Future<List<dynamic>> fetchBabysittersByBooleansAndPriceAndDis(
      double startPrice, double endPrice, double minDis, double maxDis) async {
    final response = await ServerManager().getRequestwithManyParams(
        'search_multiple/' + startPrice.toString() + '/' + endPrice.toString(),
        'Babysitter',
        currentAdditionsFilters);
    final decodedBody = json.decode(response.body);
    return decodedBody;
  }

  Future<List<dynamic>> fetchBabysittersByName() async {
    final response = await ServerManager()
        .getRequest('search_contain/fullName/' + name!, 'Babysitter');
    final decodedBody = json.decode(response.body);
    return decodedBody;
  }

  Future<List<dynamic>> sortByDis(List babysitters) async {
    List<dynamic> result = [];
    final response = await ServerManager()
        .getRequest('items/' + AppUser.getUid(), AppUser.getUserType());
    for (var babysitter in babysitters.reversed) {
      await AuthService.calculateDistance(
              babysitter['address'], json.decode(response.body)['address'])
          .then((value) {
        if (value != null && ByName == false) {
          if (value / 1000 <= maxDis && value / 1000 >= minDis) {
            dynamic babysitter2 = babysitter;
            babysitter2['dis'] = value / 1000;
            result.add(babysitter2);
          }
        } else if (value != null && ByName == true) {
          dynamic babysitter2 = babysitter;
          babysitter2['dis'] = value / 1000;
          result.add(babysitter2);
        }
      });
    }
    babysitters = result;

    return babysitters;
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
              fit: BoxFit.cover,
              opacity: 0.3)),
      child: SingleChildScrollView(
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
                        FocusScope.of(context).unfocus();
                        if (name != null && name!.length > 0) {
                          setState(() {
                            ByName = true;
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
                        FocusScope.of(context).unfocus();
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
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

                  if (babysitters != null && babysitters.isNotEmpty) {
                    babysittersFutureDisSort = sortByDis(babysitters);

                    return FutureBuilder(
                      future: babysittersFutureDisSort,
                      builder: (context, distanceSnapshot) {
                        if (distanceSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting for the distance calculations to complete, show a progress indicator
                          return CircularProgressIndicator();
                        } else if (distanceSnapshot.hasError) {
                          // If there's an error in distance calculation, display an error message
                          return Text('Error: ${distanceSnapshot.error}');
                        } else {
                          List? babysitters2 = distanceSnapshot.data;
                          // Once the distance calculations complete successfully, render the list of babysitters
                          return Column(
                            children: babysitters2 != null &&
                                    babysitters2.isNotEmpty
                                ? babysitters2.reversed.map(
                                    (babysitter) {
                                      if (true) {
                                        return BabysitterSearchCard(
                                          imageUrl: babysitter['image'],
                                          babysitter_email: babysitter['email'],
                                          babysitter_name:
                                              babysitter['firstName'] +
                                                  ' ' +
                                                  babysitter['lastName'],
                                          dis: babysitter['dis'],
                                        );
                                      }
                                    },
                                  ).toList()
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
                    );
                  } else {
                    return Text(
                      'No Results',
                      style: GoogleFonts.workSans(
                        color: Colors.black,
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
