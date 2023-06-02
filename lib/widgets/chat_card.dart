import 'package:baby_sitter/screens/chat_page_screen.dart';
import 'package:flutter/material.dart';
import '../models/Chat.dart';

class ChatCard extends StatefulWidget {
  final Chat chat;
  const ChatCard({super.key, required this.chat});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
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
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => new ChatPageScreen()));
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              widget.chat.userImage,
            ),
            backgroundColor:
                Theme.of(context).colorScheme.primary.withAlpha(180),
            radius: 23,
          ),
          title: Text(widget.chat.username),
          subtitle: Text(widget.chat.text),
          trailing: Text(
            widget.chat.createdAt,
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
