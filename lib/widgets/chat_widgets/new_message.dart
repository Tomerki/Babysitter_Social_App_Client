import 'package:baby_sitter/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/appUser.dart';

class NewMessage extends StatefulWidget {
  String secondUserUid;
  String chatId, type;
  NewMessage({
    super.key,
    required this.secondUserUid,
    required this.chatId,
    required this.type,
  });

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    _messageController.clear();

    String collectionName = AppUser.getUserType();
    final user = FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(AppUser.getUid())
        .get();

    final secondUserData = await AuthService.firestore
        .collection(widget.type)
        .where('uid', isEqualTo: widget.secondUserUid)
        .get();

    final secondData = secondUserData.docs.first.data();
    AuthService.sendPushNotification(secondData['email'], enteredMessage);

    AuthService.firestore
        .collection(AppUser.getUserType())
        .doc(AppUser.getUid())
        .collection('chats')
        .doc(widget.secondUserUid)
        .update({
      'lastMessage': enteredMessage,
      'lastMessageDate': Timestamp.now(),
      'fullName': secondData['fullName'],
      'userImage': secondData['image'],
    });

    AuthService.firestore
        .collection(widget.type)
        .doc(widget.secondUserUid)
        .collection('chats')
        .doc(AppUser.getUid())
        .update({
      'lastMessage': enteredMessage,
      'lastMessageDate': Timestamp.now(),
      'fullName': userData['fullName'],
      'userImage': userData['image'],
    });

    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(widget.chatId)
        .collection('Messages')
        .add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'username': userData.data()!['fullName'],
      'userImage': userData.data()!['image'],
      'uid': user.uid
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(children: [
        Expanded(
          child: TextField(
            style: GoogleFonts.workSans(
              color: Colors.black,
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(
              labelText: 'Send a message...',
            ),
          ),
        ),
        IconButton(
          onPressed: _submitMessage,
          icon: Icon(
            Icons.send,
          ),
        ),
      ]),
    );
  }
}
