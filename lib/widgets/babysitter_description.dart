import 'package:flutter/material.dart';

class BabysitterDescription extends StatelessWidget {
  final double pageHight;
  final double pagewidth;
  final String description;

  const BabysitterDescription(
      {super.key,
      required this.pageHight,
      required this.pagewidth,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white,
        border: Border.all(
          color: Color.fromARGB(255, 129, 91, 91),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: pageHight * 0.25,
      width: pagewidth * 0.9,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description: ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
