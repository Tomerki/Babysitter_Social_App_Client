import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BabysitterUpperPage extends StatelessWidget {
  final double pageHight;
  final double pagewidth;
  final String name;
  final String age;

  const BabysitterUpperPage(
      {super.key,
      required this.pageHight,
      required this.pagewidth,
      required this.name,
      required this.age});

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
                style: GoogleFonts.workSans(
                  color: Colors.black,
                  textStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                'Country and City',
                style: GoogleFonts.workSans(
                  color: Colors.black,
                  textStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
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
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Text(
                            'Reviews',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            age,
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Text(
                            'age',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
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
