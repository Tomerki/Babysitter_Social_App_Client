import 'package:baby_sitter/widgets/chat_messages.dart';
import 'package:baby_sitter/widgets/new_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatPageScreen extends StatefulWidget {
  static final routeName = 'ChatPageScreen';
  const ChatPageScreen({super.key});

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Column(children: const [
        Expanded(
          child: ChatMessages(),
        ),
        NewMessage(),
      ]),
    );
  }
}
