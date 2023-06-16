import 'package:baby_sitter/models/appUser.dart';
import 'package:baby_sitter/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/chat_widgets/chat_messages.dart';
import '../widgets/chat_widgets/new_message.dart';
import 'package:flutter/material.dart';

class ChatPageScreen extends StatefulWidget {
  static final routeName = 'ChatPageScreen';
  String secondUid;
  String secondUserType;
  String chatId;
  String secondUserName = 'Chat';

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
  Future<String> getSecondUserName() async {
    final documentRef = await AuthService.firestore
        .collection(AppUser.getUserType())
        .doc(AppUser.getUid())
        .collection('chats')
        .doc(widget.secondUid)
        .get();
    String secondUserName = documentRef.data()!['fullName'];
    return secondUserName;
  }

  @override
  void initState() {
    getSecondUserName().then((value) {
      setState(() {
        widget.secondUserName = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.secondUserName,
          style: GoogleFonts.workSans(
            color: Colors.black,
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 129, 100, 110).withOpacity(0.2),
        elevation: 5.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
