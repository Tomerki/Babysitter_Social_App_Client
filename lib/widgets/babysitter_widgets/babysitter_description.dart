import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              style: GoogleFonts.workSans(
                color: Colors.black87,
                textStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                description,
                style: GoogleFonts.workSans(
                  color: Colors.black87,
                  textStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
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
