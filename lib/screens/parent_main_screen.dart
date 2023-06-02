import 'package:baby_sitter/screens/babysitter_profile_screen.dart';
import 'package:baby_sitter/screens/babysitter_search_screen.dart';
import 'package:baby_sitter/screens/chats_screen.dart';
import 'package:baby_sitter/screens/filter_screen.dart';
import 'package:baby_sitter/screens/jobs_search_screen.dart';
import 'package:baby_sitter/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../server_manager.dart';
import '../widgets/main_drawer.dart';

class ParentMainScreen extends StatefulWidget {
  const ParentMainScreen({Key? key}) : super(key: key);
  static final routeName = 'ParentMainScreen';

  @override
  State<ParentMainScreen> createState() => _ParentMainScreenState();
}

class _ParentMainScreenState extends State<ParentMainScreen> {
  List<Widget> _screens = [];
  String? user_body;
  @override
  void didChangeDependencies() {
    user_body = ModalRoute.of(context)!.settings.arguments as String;
    _screens = [
      JobsSearchScreen(
        user_body: user_body!,
      ),
      NotificationScreen(),
      BabysitterSearchScreen(),
      ChatsScreen(),
      BabysitterProfileScreen(
        user_body: user_body!,
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.notifications),
          title: ("Notifications"),
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.search, color: Colors.white),
          title: ("Search"),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.email),
          title: ("Inbox"),
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite),
          title: ("Favorites"),
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      drawer: MainDrawer(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _screens,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        // popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }
}
