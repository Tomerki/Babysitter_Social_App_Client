import 'dart:convert';

import 'package:baby_sitter/models/appUser.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../server_manager.dart';

class RecommendationPost extends StatefulWidget {
  final recommendation;
  bool hide;
  Function() callback;
  RecommendationPost(
      {super.key,
      required this.recommendation,
      required this.hide,
      required this.callback});

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
                            onPressed: () async {
                              await ServerManager()
                                  .deleteRequest(
                                      'delete_inner_item_collection/' +
                                          AppUser.getUid() +
                                          '/' +
                                          (widget.recommendation)['doc_id'] +
                                          '/recommendation',
                                      'Babysitter')
                                  .then((value) {
                                widget.callback();
                              });
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
