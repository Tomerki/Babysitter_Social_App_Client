import 'package:baby_sitter/models/tempUser.dart';
import 'package:baby_sitter/screens/authenticate/authenticate.dart';
import 'package:baby_sitter/screens/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TempUser?>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      print(user.uid);
      return FilterScreen();
    }
  }
}
