import 'package:flutter/material.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class FilterScreen extends StatefulWidget {
  static final routeName = 'FilterScreen';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? minDropdownValue;
  String maxDropdownValue = 'max';
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter By'),
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      body: Center(
        child: Container(
          width: (queryData.size.width) * 0.9,
          height: (queryData.size.height - queryData.padding.top) * 0.9,
          child: Container(
            child: Column(
              children: [
                Text('Price'),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'min',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'max',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// DropdownButton<String>(
//   hint: Text('min'),
//   value: minDropdownValue,
//   underline: Container(
//     height: 2,
//     color: Colors.deepPurpleAccent,
//   ),
//   onChanged: (String? value) {
//     // This is called when the user selects an item.
//     setState(() {
//       minDropdownValue = value!;
//     });
//   },
//   items: list.map<DropdownMenuItem<String>>((String val) {
//     return DropdownMenuItem<String>(
//       value: val,
//       child: Text(val),
//     );
//   }).toList(),
// ),
