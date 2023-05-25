import 'package:baby_sitter/widgets/job_post.dart';
import 'package:baby_sitter/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/new_post.dart';

class JobsSearchScreen extends StatefulWidget {
  static final routeName = 'JobsSearchScreen';
  const JobsSearchScreen({super.key});

  @override
  State<JobsSearchScreen> createState() => _JobsSearchScreenState();
}

class _JobsSearchScreenState extends State<JobsSearchScreen> {
  List jobs = [];

  callback(List newJobs) {
    setState(() {
      jobs = newJobs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs Search'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NewPost(
                  callback: callback,
                ),
                ...jobs.reversed.map(
                  (job) {
                    return JobPost(
                      job: job,
                      hide: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
