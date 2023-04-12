import '../widgets/job_post.dart';
import 'package:flutter/material.dart';

class JobsSearchScreen extends StatefulWidget {
  static final routeName = 'JobsSearchScreen';
  const JobsSearchScreen({super.key});

  @override
  State<JobsSearchScreen> createState() => _JobsSearchScreenState();
}

class _JobsSearchScreenState extends State<JobsSearchScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs Search'),
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  //write new poxt
                  Container(
                    height: (queryData.size.height) * 0.2,
                    color: Colors.black,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<int>.generate(5, (index) => index + 1)
                        .map((number) {
                      return JobPost(width: queryData.size.width);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
