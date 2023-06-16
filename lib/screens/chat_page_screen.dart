import '../widgets/chat_widgets/chat_messages.dart';
import '../widgets/chat_widgets/new_message.dart';
import 'package:flutter/material.dart';

class ChatPageScreen extends StatefulWidget {
  static final routeName = 'ChatPageScreen';
  String secondUid;
  String secondUserType;
  String chatId;

  ChatPageScreen({
    super.key,
    required this.secondUid,
    required this.chatId,
    required this.secondUserType,
  });

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: ChatMessages(
            secondUserUid: widget.secondUid,
            chatId: widget.chatId,
          ),
        ),
        NewMessage(
          secondUserUid: widget.secondUid,
          chatId: widget.chatId,
          type: widget.secondUserType,
        ),
      ]),
    );
  }
}
