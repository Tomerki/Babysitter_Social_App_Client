import 'package:flutter/material.dart';

class JobPost extends StatefulWidget {
  final width;
  // final fullName;
  // final DateTime postTime;

  const JobPost({super.key, this.width});

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        width: widget.width,
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Full Name',
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'Date',
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromARGB(255, 129, 91, 91),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Data on the job ',
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
