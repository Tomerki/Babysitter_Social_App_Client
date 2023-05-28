import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String lastMessage;
  final String name;
  final String hour;
  final String imageUrl;
  const ChatCard({
    super.key,
    required this.lastMessage,
    required this.name,
    required this.hour,
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
          subtitle: Text('Last message...'),
          trailing: Text(
            '12:00 PM',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
