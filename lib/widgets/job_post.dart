import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../models/appUser.dart';
import '../server_manager.dart';

class JobPost extends StatefulWidget {
  Function(List jobs) callback;
  final job;
  bool hide;
  JobPost(
      {super.key,
      required this.job,
      required this.hide,
      required this.callback});

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  List jobs = [];
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
                    padding: const EdgeInsets.only(right: 170, left: 8.0),
                    child: Text(
                      widget.job['publisher'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Job date: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.job['date']}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Hours: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.job['startHour']} - ${widget.job['endHour']}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Number of children: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' ${widget.job['childrens'] == null ? 0 : widget.job['childrens'].length}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'description: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' ${widget.job['description'] == null || widget.job['description'].length == 0 ? 'no description' : widget.job['description']}',
                            style: TextStyle(fontSize: 16),
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
                              onPressed: () async {
                                await ServerManager().postRequest(
                                    'add_inner_collection/' +
                                        (widget.job)['parent_id'] +
                                        '/notification',
                                    'Parent',
                                    body: jsonEncode(
                                      {
                                        'title':
                                            "Babysitter is interested in your post",
                                        'massage': "Click to see here page",
                                        'babysitter_id': AppUser.getUid(),
                                        'job_id': (widget.job)['doc_id'],
                                        'was_tap': false,
                                        'type': "job bell",
                                      },
                                    ));
                              },
                              icon: Icon(
                                Icons.notification_add_outlined,
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
