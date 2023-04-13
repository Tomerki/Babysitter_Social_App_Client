import 'package:baby_sitter/models/tempUser.dart';
import 'package:baby_sitter/screens/wrapper.dart';
import 'package:baby_sitter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/babysitter_profile_screen.dart';
import './screens/login_screen.dart';
import './screens/welcome_screen.dart';
import './screens/register_screen.dart';
import './screens/babysitter_register_screen.dart';
import './screens/parent_register_screen.dart';
import './widgets/map_place_picker.dart';
import './screens/filter_screen.dart';
import './screens/jobs_search_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TempUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: WelcomeScreen.routeName,
        // initialRoute: FilterScreen.routeName,
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
        home: Wrapper(),
      ),
    );
  }
}
