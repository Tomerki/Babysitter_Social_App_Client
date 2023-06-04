import 'package:baby_sitter/models/appUser.dart';
import 'package:baby_sitter/services/auth.dart';
import '../widgets/chat_card.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController emailController = TextEditingController();

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
              onPressed: () async {
                final email = emailController.text.trim();
                emailController.clear();
                if (email.isNotEmpty) {
                  await AuthService.addChatUser(email);
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
            stream: AuthService.firestore
                .collection(AppUser.getUserType())
                .doc(AppUser.getUid())
                .collection('chats')
                .orderBy(
                  'lastMessageDate',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
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

              final loadedChatsCard = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: mq.size.height * .01),
                    physics: BouncingScrollPhysics(),
                    itemCount: loadedChatsCard.length,
                    itemBuilder: (ctx, index) {
                      final chatCards = loadedChatsCard[index].data();
                      return ChatCard(
                        message: chatCards['lastMessage'],
                        createdAt: chatCards['lastMessageDate'],
                        userImage: chatCards['userImage'],
                        username: chatCards['fullName'],
                        secondUserUid: chatCards['uid'],
                        chatId: chatCards['chatId'],
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
