import 'package:baby_sitter/models/appUser.dart';
import 'package:baby_sitter/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chat_widgets/chat_card.dart';
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
          title: Text(
            'Enter User Email',
            style: GoogleFonts.workSans(
              color: Colors.black,
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          content: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.workSans(
                  color: Color.fromARGB(255, 81, 26, 26).withOpacity(0.8),
                  textStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Add',
                style: GoogleFonts.workSans(
                  color: Color.fromARGB(255, 17, 78, 127),
                  textStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
              fit: BoxFit.cover,
              opacity: 0.3),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _showEmailDialog(context),
              child: Text(
                'Add Chat By Email',
                style: GoogleFonts.workSans(
                  color: Colors.white,
                  textStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                backgroundColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              ),
            ),
            SizedBox(
              height: 10,
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
                  return Center(
                    child: Text(
                      'No Chats found',
                      style: GoogleFonts.workSans(
                        color: Colors.black,
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
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
      ),
    );
  }
}
