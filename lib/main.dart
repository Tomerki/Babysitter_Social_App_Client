import 'dart:developer';

import 'package:baby_sitter/models/appUser.dart';
import 'package:baby_sitter/screens/babysitter_main_screen.dart';
import 'package:baby_sitter/screens/babysitter_search_screen.dart';
import 'package:baby_sitter/screens/favorites_screen.dart';
import 'package:baby_sitter/screens/parent_main_screen.dart';
import 'package:baby_sitter/services/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/login_screen.dart';
import './screens/welcome_screen.dart';
import './screens/register_screen.dart';
import './screens/babysitter_register_screen.dart';
import './widgets/map_place_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // void navigateToScreen(Map<String, dynamic> notificationData) {
  //   log(notificationData.toString());
  // }

  @override
  Widget build(BuildContext context) {
    // AuthService.fcm.getInitialMessage().then((RemoteMessage? message) {
    //   if (message != null) {
    //     // Extract the necessary data from the message and navigate to the desired screen
    //     final notificationData = message.data;
    //     navigateToScreen(notificationData);
    //   } else {
    //     log("Null");
    //   }
    // });

    return StreamProvider<AppUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          BabysitterRegisterScreen.routeName: (context) =>
              BabysitterRegisterScreen(),
          MapPlacePicker.routeName: (context) => MapPlacePicker(),
          BabysitterSearchScreen.routeName: (context) =>
              BabysitterSearchScreen(),
          ParentMainScreen.routeName: (context) => ParentMainScreen(),
          BabysitterMainScreen.routeName: (context) => BabysitterMainScreen(),
          FavoritesScreen.routeName: (context) => FavoritesScreen(),
        },
        home: WelcomeScreen(),
      ),
    );
  }
}
