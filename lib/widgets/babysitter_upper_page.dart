import 'package:flutter/material.dart';

class BabysitterUpperPage extends StatelessWidget {
  final double pageHight;
  final double pagewidth;
  final String name;

  const BabysitterUpperPage(
      {super.key,
      required this.pageHight,
      required this.pagewidth,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      //card column
      child: Stack(
        children: [
          Column(
            children: [
              Spacer(),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://anaphotography.co.uk/wp-content/uploads/2022/03/Child-Toddler-Photography-Bodmin-Cornwall-269.jpg'),
                radius: (pageHight) * 0.4 * 0.25,
              ),
              //ToDo: Full Name in bold, Country and City in light
              Text(
                name,
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
                  width: (pagewidth) * 0.9 * 0.7,
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
        ],
      ),
    );
  }
}
