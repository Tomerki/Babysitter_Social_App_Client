import 'dart:convert';
import 'package:baby_sitter/models/appUser.dart';
import 'package:baby_sitter/widgets/job_post.dart';
import 'package:baby_sitter/widgets/loading.dart';
import 'package:flutter/material.dart';
import '../server_manager.dart';
import '../widgets/new_post.dart';

class JobsSearchScreen extends StatefulWidget {
  static final routeName = 'JobsSearchScreen';
  final String user_body;
  const JobsSearchScreen({super.key, required this.user_body});

  @override
  State<JobsSearchScreen> createState() => _JobsSearchScreenState();
}

class _JobsSearchScreenState extends State<JobsSearchScreen> {
  Future<List<dynamic>>? jobsFuture;

  @override
  void initState() {
    super.initState();
    jobsFuture = fetchJobs();
  }

  Future<List<dynamic>> fetchJobs() async {
    final response = await ServerManager().getRequest('items', 'Jobs');
    final decodedBody = json.decode(response.body);
    return decodedBody;
  }

  void updateJobs(List<dynamic> newJobs) {
    setState(() {
      jobsFuture = Future.value(newJobs);
    });
  }

  @override
  Widget build(BuildContext context) {
    var decoded_user_body = json.decode(widget.user_body);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.topCenter,
            child: FutureBuilder<List<dynamic>>(
              future: jobsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for the future to complete, show a progress indicator
                  return Loading();
                } else if (snapshot.hasError) {
                  // If there's an error, display an error message
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Once the future completes successfully, render the list
                  List? jobs = snapshot.data;
                  return Column(children: [
                    (!AppUser.getUserKind()
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NewPost(
                              callback: updateJobs,
                              publisherName: decoded_user_body['firstName'] +
                                  ' ' +
                                  decoded_user_body['lastName'],
                              parentId: decoded_user_body['uid'],
                            ),
                          )
                        : SizedBox()),
                    if (jobs != null && !jobs.isEmpty)
                      ...jobs.map((job) {
                        return JobPost(
                          callback: updateJobs,
                          job: job,
                          hide: true,
                          isJobRequestSent: false,
                        );
                      }).toList()
                    else
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('No Posts Yet'),
                      ),
                  ]);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
