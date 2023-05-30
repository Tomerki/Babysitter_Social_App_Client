import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/appUser.dart';
import '../server_manager.dart';

class FavoritesScreen extends StatefulWidget {
  static final routeName = 'FavoritesScreen';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenScreenState();
}

class _FavoritesScreenScreenState extends State<FavoritesScreen> {
  Future<dynamic>? favoritesFuture;

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

  Future<dynamic> fetchFavorites() async {
    final response =
        await ServerManager().getRequest('items/' + AppUser.getUid(), 'Parent');
    final decodedBody = json.decode(response.body);
    return decodedBody['favorites'];
  }

  void updateFavoritess(List<dynamic> newFavorites) {
    setState(() {
      favoritesFuture = Future.value(newFavorites);
    });
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
              FutureBuilder<dynamic>(
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
                    List? favorites = snapshot.data;
                    return Column(
                      children: favorites != null && favorites.isNotEmpty
                          ? favorites.map((favorite) {
                              return Text(
                                  favorite); // Replace with your desired widget
                            }).toList()
                          : [Text('No Favorites')],
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
