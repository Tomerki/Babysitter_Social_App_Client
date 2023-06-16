import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:baby_sitter/screens/chat_page_screen.dart';
import 'package:baby_sitter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ChatCard extends StatefulWidget {
  var userImage;
  var username;
  var message;
  var createdAt;
  var secondUserUid;
  var chatId;

  ChatCard({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.createdAt,
    required this.secondUserUid,
    required this.chatId,
  });

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    String truncateMessage(String message, int maxLength) {
      if (message.length <= maxLength) {
        return message;
      } else {
        return message.substring(0, maxLength) + '...';
      }
    }

    final mediaQuery = MediaQuery.of(context);
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: mediaQuery.size.width * .02,
        vertical: 4,
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () async {
          AuthService.firestore
              .collection('Users')
              .where('uid', isEqualTo: widget.secondUserUid)
              .get()
              .then((value) {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: ChatPageScreen(
                secondUid: widget.secondUserUid,
                chatId: widget.chatId,
                secondUserType: value.docs.first.data()['isBabysitter']
                    ? 'Babysitter'
                    : 'Parent',
              ),
              withNavBar: false,
            );
          });
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              widget.userImage,
            ),
            backgroundColor:
                Theme.of(context).colorScheme.primary.withAlpha(180),
            radius: 23,
          ),
          title: Text(
            widget.username,
            style: GoogleFonts.workSans(
              color: Colors.black,
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          subtitle: Text(
            truncateMessage(widget.message, 18),
            style: GoogleFonts.workSans(
              color: Colors.black,
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          trailing: Text(
            DateFormat('hh:mm a').format(widget.createdAt.toDate()),
            style: GoogleFonts.workSans(
              color: Colors.black54,
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
