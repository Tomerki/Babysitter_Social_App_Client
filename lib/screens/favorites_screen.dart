import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/appUser.dart';
import '../server_manager.dart';
import '../widgets/babysitter_search_card.dart';

class FavoritesScreen extends StatefulWidget {
  static final routeName = 'FavoritesScreen';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenScreenState();
}

class _FavoritesScreenScreenState extends State<FavoritesScreen> {
  Future<List<dynamic>>? favoritesFuture;

  @override
  void initState() {
    super.initState();
    favoritesFuture = fetchFavorites();
  }

  @override
  void didChangeDependencies() {
    favoritesFuture = fetchFavorites();
    super.didChangeDependencies();
  }

  Future<List<dynamic>> fetchFavorites() async {
    var decodedBody = {};
    var result;
    Map<String, String> favoritesMap = {};
    await ServerManager()
        .getRequest('items/' + AppUser.getUid(), 'Parent')
        .then((value) async {
      decodedBody['favorites'] = json.decode(value.body)['favorites'];

      for (int i = 0; i < decodedBody['favorites'].length; i++) {
        favoritesMap[decodedBody['favorites'][i]] = decodedBody['favorites'][i];
      }
      await ServerManager()
          .getRequestwithManyParams('items_filter', 'Babysitter', favoritesMap)
          .then((value) {
        result = json.decode(value.body);
      });
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<dynamic>>(
                future: favoritesFuture,
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
                          : [Text('No Results')],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
