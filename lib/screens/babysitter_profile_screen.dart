import 'package:baby_sitter/widgets/babysitter_upper_page.dart';
import 'package:flutter/material.dart';
import 'package:baby_sitter/widgets/babysitter_middle_page.dart';
import 'package:baby_sitter/widgets/babysitter_description.dart';

class BabysitterProfileScreen extends StatefulWidget {
  static final routeName = 'BabysitterProfileScreen';

  @override
  State<BabysitterProfileScreen> createState() =>
      _BabysitterProfileScreenState();
}

class _BabysitterProfileScreenState extends State<BabysitterProfileScreen> {
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    // .then((pickDate) {
    //   if (pickDate == null) {
    //     return;
    //   } else {
    //     setState(() {
    //       _selectedDate = pickDate;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('babysitter Page'),
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: _presentDatePicker,
            child: Text('  BOOK  '),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 174, 194, 182),
              padding: EdgeInsets.all(15),

              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 5,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Icon(
              Icons.chat,
              size: 26,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 183, 202, 219),
              elevation: 5,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          10,
        ),
        //all page column
        child: Center(
          child: Container(
            color: Colors.white70,
            width: (queryData.size.width),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Card(
                    elevation: 5,
                    color: Colors.white70,
                    child: SizedBox(
                      // width: (queryData.size.width) * 0.9,
                      height:
                          (queryData.size.height - queryData.padding.top) * 0.4,
                      child: BabysitterUpperPage(
                        pageHight:
                            (queryData.size.height - queryData.padding.top),
                        pagewidth: queryData.size.width,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: BabysitterMiddlePage(),
                ),
                BabysitterDescription(
                  pageHight: queryData.size.height - queryData.padding.top,
                  pagewidth: queryData.size.width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
