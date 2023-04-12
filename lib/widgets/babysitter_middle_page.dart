import 'package:flutter/material.dart';

class BabysitterMiddlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Color.fromARGB(200, 129, 91, 91),
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
            color: Color.fromARGB(200, 129, 91, 91),
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
    );
  }
}
