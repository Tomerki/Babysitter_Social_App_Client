import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BabysitterUpperPage extends StatelessWidget {
  final double pageHight;
  final double pagewidth;
  final String name;
  final String age;
  final String address;
  final String mail;
  final String image;
  final int reviews;
  const BabysitterUpperPage({
    super.key,
    required this.pageHight,
    required this.pagewidth,
    required this.name,
    required this.age,
    required this.address,
    required this.mail,
    required this.image,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Spacer(),
                CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: (pageHight) * 0.4 * 0.25,
                ),
                Center(
                  child: Text(
                    name,
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    address,
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    mail,
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: (pagewidth) * 0.9 * 0.7,
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              reviews.toString(),
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
          ),
        ],
      ),
    );
  }
}
