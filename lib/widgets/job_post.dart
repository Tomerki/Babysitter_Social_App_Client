import 'dart:convert';
import 'dart:developer';

import 'package:baby_sitter/services/auth.dart';
import 'custom_widgets/icon_with_description.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/appUser.dart';
import '../server_manager.dart';

class JobPost extends StatefulWidget {
  Function(List jobs) callback;
  final job;
  bool hide, isJobRequestSent;
  JobPost({
    super.key,
    required this.job,
    required this.hide,
    required this.callback,
    required this.isJobRequestSent,
  });

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  List jobs = [];
  String image =
      'https://w7.pngwing.com/pngs/981/645/png-transparent-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette-symbol.png';
  String email = '';
  Future<String> fetchImage() async {
    final response = await ServerManager()
        .getRequest('items/' + widget.job['parent_id'], 'Parent');
    final decodedBody = json.decode(response.body);

    return (decodedBody['image']);
  }

  Future<String> fetchEmail() async {
    final response = await ServerManager()
        .getRequest('items/' + widget.job['parent_id'], 'Parent');
    final decodedBody = json.decode(response.body);

    return (decodedBody['email']);
  }

  @override
  void initState() {
    fetchImage().then((value) {
      setState(() {
        image = value;
      });
    });
    fetchEmail().then((value) {
      setState(() {
        email = value;
      });
    });
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    final data = await AuthService.firestore
        .collection('Parent')
        .doc(widget.job['parent_id'])
        .collection('notification')
        .where('babysitter_id', isEqualTo: AppUser.getUid())
        .get();

    if (data.docs.isNotEmpty) {
      setState(() {
        widget.isJobRequestSent = true;
      });
    }
  }

  void _showSnackMessage(String content, String label) {
    if (widget.isJobRequestSent) {
      return;
    }
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
        .then((SnackBarClosedReason reason) {
      if (reason == SnackBarClosedReason.action) {
        // Snack bar was dismissed by pressing the action button
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color.fromARGB(255, 76, 95, 111),
            content: Text(
              "Job request canceled!",
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
        sendJobRequest();
      }
    });
  }

  void sendJobRequest() async {
    await ServerManager().postRequest(
      'add_inner_collection/' + widget.job['parent_id'] + '/notification',
      'Parent',
      body: jsonEncode(
        {
          'title': "Babysitter is interested in your post",
          'massage': "Click to see here page",
          'babysitter_id': AppUser.getUid(),
          'job_id': widget.job['doc_id'],
          'was_tap': false,
          'type': "job bell",
        },
      ),
    );
    setState(() {
      widget.isJobRequestSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(image),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.job['publisher'],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Email: ',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            email,
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
                      Row(
                        children: [
                          Text(
                            'Job date: ',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.job['date']}'.substring(0, 10),
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
                      Row(
                        children: [
                          Text(
                            'Hours: ',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.job['startHour']} - ${widget.job['endHour']}',
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
                      Row(
                        children: [
                          Text(
                            'Number of children: ',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            ' ${widget.job['childrens'] == null ? 0 : widget.job['childrens'].length}',
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
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${widget.job['description'] == null || widget.job['description'].length == 0 ? 'no description' : widget.job['description']}',
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AppUser.getUserKind()
                  ? Visibility(
                      visible: widget.hide,
                      child: Card(
                        elevation: 5,
                        borderOnForeground: true,
                        child: Row(
                          children: [
                            IconButton(
                              alignment: Alignment.bottomLeft,
                              onPressed: () {
                                if (!widget.isJobRequestSent) {
                                  _showSnackMessage(
                                      "Job request sent!", "Undo");
                                }
                              },
                              icon: IconWithDescription(
                                icon: widget.isJobRequestSent
                                    ? Icons.done
                                    : Icons.notification_add_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : (AppUser.getUid() == widget.job['parent_id']
                      ? Visibility(
                          visible: widget.hide,
                          child: Card(
                            elevation: 5,
                            borderOnForeground: true,
                            child: Row(
                              children: [
                                IconButton(
                                  alignment: Alignment.bottomLeft,
                                  onPressed: () async {
                                    await ServerManager()
                                        .deleteRequest(
                                            'items/' + (widget.job)['doc_id'],
                                            'Jobs')
                                        .then((response) async {
                                      await ServerManager()
                                          .getRequest(
                                        'items',
                                        'Jobs',
                                      )
                                          .then((newList) {
                                        jobs = json.decode(newList.body);
                                        widget.callback(jobs);
                                      });
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Visibility(
                          visible: widget.hide,
                          child: Card(
                            elevation: 5,
                            borderOnForeground: true,
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
