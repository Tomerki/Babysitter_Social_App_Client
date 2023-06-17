import 'package:baby_sitter/models/appUser.dart';
import 'screens/babysitter_screens/babysitter_main_screen.dart';
import 'screens/babysitter_screens/babysitter_search_screen.dart';
import 'screens/parent_screens/favorites_screen.dart';
import 'screens/parent_screens/parent_main_screen.dart';
import 'package:baby_sitter/server_manager.dart';
import 'package:baby_sitter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/login_screen.dart';
import './screens/welcome_screen.dart';
import './screens/register_screen.dart';
import './screens/babysitter_screens/babysitter_register_screen.dart';
import './widgets/map_place_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/sharedPreferencesHelper.dart';

Widget? homeScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesHelper.init();
  String userId = SharedPreferencesHelper.getLoggedInUserId();
  String userType = SharedPreferencesHelper.getLoggedInUserType();
  String email = SharedPreferencesHelper.getLoggedInUserEmail();

  if (userId.isNotEmpty && userType.isNotEmpty) {
    // User is logged in
    if (userType == 'Babysitter') {
      await ServerManager()
          .getRequest('search/email/' + email, 'Babysitter')
          .then(
        (user) async {
          homeScreen = BabysitterMainScreen(
            user_body: user.body,
          );
        },
      );
      AppUser.updateInstance(
        uid: userId,
        isBabysitter: true,
        userType: 'Babysitter',
      );
    } else {
      await ServerManager().getRequest('search/email/' + email, 'Parent').then(
        (user) async {
          homeScreen = ParentMainScreen(
            user_body: user.body,
          );
        },
      );
      AppUser.updateInstance(
        uid: userId,
        isBabysitter: false,
        userType: 'Parent',
      );
    }
    AuthService.setUserData();
  } else {
    // User is not logged in
    homeScreen = WelcomeScreen();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        home: homeScreen,
      ),
    );
  }
}
