import 'package:flutter/material.dart';
import './screens/babysitter_profile_screen.dart';
import './screens/login_screen.dart';
import './screens/welcome_screen.dart';
import './screens/register_screen.dart';
import './screens/babysitter_register_screen.dart';
import './screens/parent_register_screen.dart';
import './widgets/map_place_picker.dart';
import './screens/filter_screen.dart';
import './screens/jobs_search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: JobsSearchScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        BabysitterProfileScreen.routeName: (context) =>
            BabysitterProfileScreen(),
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ParentRegisterScreen.routeName: (context) => ParentRegisterScreen(),
        BabysitterRegisterScreen.routeName: (context) =>
            BabysitterRegisterScreen(),
        MapPlacePicker.routeName: (context) => MapPlacePicker(),
        FilterScreen.routeName: (context) => FilterScreen(),
        JobsSearchScreen.routeName: (context) => JobsSearchScreen(),
      },
    );
  }
}
