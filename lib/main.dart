import 'package:baby_sitter/screens/filter_sec_screen.dart';
import 'package:flutter/material.dart';
import './screens/babysitter_profile_screen.dart';
import './screens/login_screen.dart';
import './screens/welcome_screen.dart';
import './screens/filter_screen.dart';
import './screens/jobs_search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: WelcomeScreen.routeName,
      // initialRoute: BabysitterProfileScreen.routeName,
      // initialRoute: FilterScreen.routeName,
      initialRoute: JobsSearchScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        BabysitterProfileScreen.routeName: (context) =>
            BabysitterProfileScreen(),
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        FilterScreen.routeName: (context) => FilterScreen(),
        JobsSearchScreen.routeName: (context) => JobsSearchScreen(),
      },
    );
  }
}
