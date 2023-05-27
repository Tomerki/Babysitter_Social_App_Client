import 'package:flutter/material.dart';

class JobPost extends StatefulWidget {
  final job;
  bool hide;
  JobPost({super.key, required this.job, required this.hide});

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 170, left: 8.0),
                  child: Text(
                    widget.job['publisher'],
                    style: TextStyle(fontSize: 20),
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
                  'job date: ${widget.job['date']}\n' +
                      'hours: ${widget.job['startHour']} - ${widget.job['endHour']}\n' +
                      'Number of children: ${widget.job['childrens'] == null ? 0 : widget.job['childrens'].length}\n' +
                      'description: ${widget.job['description']}',
                ),
              ),
            ),
            Visibility(
              visible: widget.hide,
              child: Card(
                elevation: 5,
                borderOnForeground: true,
                child: Row(
                  children: [
                    IconButton(
                      alignment: Alignment.bottomLeft,
                      onPressed: () {},
                      icon: Icon(
                        Icons.notification_add_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
