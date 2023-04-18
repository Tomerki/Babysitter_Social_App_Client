import 'package:flutter/material.dart';

class BabysitterSearchResultsScreen extends StatefulWidget {
  const BabysitterSearchResultsScreen({super.key});
  static final routeName = 'BabysitterSearchResultsScreen';

  @override
  State<BabysitterSearchResultsScreen> createState() =>
      _BabysitterSearchResultsScreenState();
}

class _BabysitterSearchResultsScreenState
    extends State<BabysitterSearchResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Column(children: []),
    );
  }
}
