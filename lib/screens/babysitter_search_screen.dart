import 'package:baby_sitter/screens/filter_screen.dart';
import 'package:baby_sitter/widgets/input_box.dart';
import 'package:flutter/material.dart';

class BabysitterSearchScreen extends StatefulWidget {
  const BabysitterSearchScreen({super.key});
  static final routeName = 'BabysitterSearchScreen';

  @override
  State<BabysitterSearchScreen> createState() => _BabysitterSearchScreenState();
}

class _BabysitterSearchScreenState extends State<BabysitterSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for babysitter'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(188, 227, 183, 160),
              Color.fromARGB(255, 236, 232, 217),
              Color.fromARGB(255, 250, 246, 233),
            ],
          ),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: queryData.size.width * 0.8,
                  child: InputBox(
                    keyType: TextInputType.name,
                    text: "Enter a name",
                    validator: () {},
                    onChanged: () {},
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(FilterScreen.routeName);
                  },
                  icon: Icon(Icons.tune),
                  iconSize: 32,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
