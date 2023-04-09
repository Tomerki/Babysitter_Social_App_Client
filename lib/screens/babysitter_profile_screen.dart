import 'package:baby_sitter/widgets/babysitter_upper_page.dart';
import 'package:flutter/material.dart';
import '';

class BabysitterProfileScreen extends StatefulWidget {
  static final routeName = 'BabysitterProfileScreen';

  @override
  State<BabysitterProfileScreen> createState() =>
      _BabysitterProfileScreenState();
}

class _BabysitterProfileScreenState extends State<BabysitterProfileScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('babysitter Page'),
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 10,
        ),
        //all page column
        child: Column(
          children: [
            Center(
              child: Card(
                elevation: 5,
                color: Color.fromARGB(255, 254, 252, 243),
                child: SizedBox(
                  width: (queryData.size.width) * 0.9,
                  height: (queryData.size.height - queryData.padding.top) * 0.4,
                  child: BabysitterUpperPage(
                    pageHight: (queryData.size.height - queryData.padding.top),
                    pagewidth: queryData.size.width,
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Color.fromARGB(255, 129, 91, 91),
                      elevation: 5,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.payment_sharp,
                              size: 40,
                            ),
                          ],
                        ),
                        title: Text(
                          '20\$\h',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        subtitle: Text(
                          'Hourly Rate',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 5,
                      color: Color.fromARGB(255, 129, 91, 91),
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.join_inner_sharp,
                              size: 40,
                            ),
                          ],
                        ),
                        title: Text(
                          '100%',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        subtitle: Text(
                          'Matching',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
