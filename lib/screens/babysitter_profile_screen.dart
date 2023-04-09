import 'package:flutter/material.dart';

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
        backgroundColor: Color.fromARGB(179, 244, 210, 201),
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
                color: Color.fromARGB(255, 255, 248, 234),
                child: SizedBox(
                  width: (queryData.size.width) * 0.9,
                  height: (queryData.size.height - queryData.padding.top) * 0.4,
                  child: Center(
                    //card column
                    child: Column(
                      children: [
                        Spacer(),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://anaphotography.co.uk/wp-content/uploads/2022/03/Child-Toddler-Photography-Bodmin-Cornwall-269.jpg'),
                          radius:
                              (queryData.size.height - queryData.padding.top) *
                                  0.4 *
                                  0.25,
                        ),
                        //ToDo: Full Name in bold, Country and City in light
                        Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Country and City',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            width: (queryData.size.width) * 0.9 * 0.7,
                            // color: Colors.white,
                            child: Row(
                              children: [
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      '58',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'Review',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      '25',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'age',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
