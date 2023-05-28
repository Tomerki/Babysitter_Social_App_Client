import 'package:flutter/material.dart';

class BabysitterSearchCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  const BabysitterSearchCard({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: mediaQuery.size.width * .02,
        vertical: 4,
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text('Name'),
          trailing: Icon(
            Icons.arrow_right_sharp,
            size: 26,
          ),
        ),
      ),
    );
  }
}
