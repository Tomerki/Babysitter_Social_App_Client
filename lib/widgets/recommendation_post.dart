import 'dart:convert';

import 'package:baby_sitter/models/appUser.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../server_manager.dart';

class RecommendationPost extends StatefulWidget {
  final recommendation;
  bool hide;
  Function() callback;
  RecommendationPost({
    super.key,
    required this.recommendation,
    required this.hide,
    required this.callback,
  });

  @override
  State<RecommendationPost> createState() => _RecommendationPostState();
}

class _RecommendationPostState extends State<RecommendationPost> {
  String image =
      'https://w7.pngwing.com/pngs/981/645/png-transparent-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette-symbol.png';

  Future<String> fetchImage() async {
    final response = await ServerManager()
        .getRequest('items/' + widget.recommendation['parent_id'], 'Parent');
    final decodedBody = json.decode(response.body);

    return (decodedBody['image']);
  }

  @override
  void initState() {
    super.initState();
    fetchImage().then((value) {
      setState(() {
        image = value;
      });
    });
  }

  void _showSnackMessage(String content, String label) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(
              content,
              style: GoogleFonts.workSans(
                color: Colors.white,
                textStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            duration: Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: label,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        )
        .closed
        .then((SnackBarClosedReason reason) async {
      if (reason == SnackBarClosedReason.action) {
        // Snack bar was dismissed by pressing the action button
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color.fromARGB(255, 76, 95, 111),
            content: Text(
              "Delete Recommendation canceled!",
              style: GoogleFonts.workSans(
                color: Colors.white,
                textStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        await ServerManager()
            .putRequest(
          'put_inner_item_collection/' +
              AppUser.getUid() +
              '/' +
              (widget.recommendation)['doc_id'] +
              '/recommendation',
          AppUser.getUserType(),
          body: jsonEncode({'is_confirmed': false}),
        )
            .then((value) {
          widget.callback();
        });
      }
    });
  }

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(image),
                      ),
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
                    ],
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
            AppUser.getUid() == widget.recommendation['babysitter_id']
                ? Visibility(
                    visible: widget.hide,
                    child: Card(
                      elevation: 5,
                      borderOnForeground: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              _showSnackMessage(
                                  "The recommendation has been deleted",
                                  "Undo");
                            },
                            icon: Icon(
                              Icons.delete,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
