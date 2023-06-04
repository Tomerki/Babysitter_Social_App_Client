import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationPost extends StatefulWidget {
  final recommendation;
  bool hide;
  RecommendationPost(
      {super.key, required this.recommendation, required this.hide});

  @override
  State<RecommendationPost> createState() => _RecommendationPostState();
}

class _RecommendationPostState extends State<RecommendationPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Text(
                    '${widget.recommendation['parent_fullName']}',
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.hide = !widget.hide;
                    });
                  },
                  icon: widget.hide
                      ? Icon(
                          Icons.minimize,
                        )
                      : Icon(
                          Icons.add,
                        ),
                ),
              ],
            ),
            Visibility(
              visible: widget.hide,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.recommendation['description']}',
                  style: GoogleFonts.workSans(
                    color: Colors.black,
                    textStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
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
