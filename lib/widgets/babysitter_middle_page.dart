import 'package:flutter/material.dart';

class BabysitterMiddlePage extends StatelessWidget {
  final double pageHight;
  final double pagewidth;
  final String price;

  const BabysitterMiddlePage(
      {super.key,
      required this.pageHight,
      required this.pagewidth,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: pageHight,
      width: pagewidth * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              color: Color.fromARGB(200, 129, 91, 91),
              elevation: 5,
              child: Center(
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
                    '${price}',
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
          ),
          Expanded(
            child: Card(
              elevation: 5,
              color: Color.fromARGB(200, 129, 91, 91),
              child: Center(
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
                    'Click',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  subtitle: Text(
                    'For more details',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
