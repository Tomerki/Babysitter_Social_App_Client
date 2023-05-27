import 'dart:convert';
import 'package:baby_sitter/widgets/job_post.dart';
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
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NewPost(
                callback: updateJobs,
                publisherName: decoded_user_body['firstName'] +
                    ' ' +
                    decoded_user_body['lastName'],
              ),
              FutureBuilder<List<dynamic>>(
                future: jobsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the future to complete, show a progress indicator
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // If there's an error, display an error message
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Once the future completes successfully, render the list
                    List? jobs = snapshot.data;
                    return Column(
                      children: jobs != null
                          ? jobs.reversed.map((job) {
                              return JobPost(
                                job: job,
                                hide: true,
                              );
                            }).toList()
                          : [Text('No Posts Yet')],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class _JobsSearchScreenState extends State<JobsSearchScreen> {
//   List<dynamic> jobs = [];
//   void jobsPosts() async {
//     await ServerManager().getRequest('items', 'Jobs').then((res) {
//       print(res.body);
//       jobs = json.decode(res.body);
//     });
//   }

//   callback(List newJobs) {
//     setState(() {
//       jobs = newJobs;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var decoded_user_body = json.decode(widget.user_body);
//     jobsPosts();
//     // return Scaffold(
//     //   // appBar: AppBar(
//     //   //   title: Text('Jobs Search'),
//     //   //   centerTitle: true,
//     //   //   backgroundColor: Color.fromARGB(255, 219, 163, 154),
//     //   // ),
//     //   body:
//     return Center(
//       child: Container(
//         alignment: Alignment.topCenter,
//         padding: EdgeInsets.all(10),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               NewPost(
//                 callback: callback,
//                 publisherName: decoded_user_body['firstName'] +
//                     ' ' +
//                     decoded_user_body['lastName'],
//               ),
//               ...jobs.reversed.map(
//                 (job) {
//                   return JobPost(
//                     job: job,
//                     hide: true,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       // ),
//     );
//   }
// }
