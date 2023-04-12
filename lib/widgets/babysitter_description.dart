import 'package:flutter/material.dart';

class BabysitterDescription extends StatelessWidget {
  final double pageHight;
  final double pagewidth;

  const BabysitterDescription(
      {super.key, required this.pageHight, required this.pagewidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color.fromARGB(255, 129, 91, 91),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: pageHight * 0.2,
      width: pagewidth * 0.9,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description: ',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text('the description........ '),
          ],
        ),
      ),
    );
  }
}
