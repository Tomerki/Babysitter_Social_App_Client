import 'dart:developer';

import 'package:baby_sitter/models/AppUser.dart';
import 'package:baby_sitter/services/auth.dart';
import 'package:baby_sitter/widgets/chat_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Chat.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Chat> list = [];
  final TextEditingController emailController = TextEditingController();
  var secondUserId = "";

  void _showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter User Email'),
          content: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                final email = emailController.text.trim();
                emailController.clear();
                if (email.isNotEmpty) {
                  setState(() async {
                    await AuthService.addChatUser(email)
                        .then((value) => secondUserId = value);
                  });

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _showEmailDialog(context),
            child: Text('Add Chat by Email'),
          ),
          StreamBuilder(
            stream: firestore
                .collection(AppUser.getUserType())
                .doc(AppUser.getUid())
                .collection('chats')
                .snapshots(),
            builder: (ctx, snapshot) {
              final data = snapshot.data?.docs;
              list = data?.map((e) => Chat.fromJson(e.data())).toList() ?? [];
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No Chats found'),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong...'),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.only(top: mq.size.height * .01),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    print(list[index].userImage);
                    return ChatCard(
                      chat: list[index],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
