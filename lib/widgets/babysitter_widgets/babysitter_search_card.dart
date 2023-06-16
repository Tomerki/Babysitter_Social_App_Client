import '../../screens/babysitter_screens/babysitter_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../server_manager.dart';

class BabysitterSearchCard extends StatefulWidget {
  final String babysitter_email;
  final String babysitter_name;
  final String imageUrl;
  final double? dis;
  const BabysitterSearchCard({
    super.key,
    required this.imageUrl,
    required this.babysitter_email,
    required this.babysitter_name,
    this.dis = -1.0,
  });

  @override
  State<BabysitterSearchCard> createState() => _BabysitterSearchCardState();
}

class _BabysitterSearchCardState extends State<BabysitterSearchCard> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      color: Colors.white.withOpacity(0.8),
      margin: EdgeInsets.symmetric(
        horizontal: mediaQuery.size.width * .02,
        vertical: 4,
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () async {
          await ServerManager()
              .getRequest(
                  'search/email/' + widget.babysitter_email, 'Babysitter')
              .then((user) {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: BabysitterProfileScreen(
                user_body: user.body,
                from_search_card: true,
              ),
              withNavBar: false,
            );
          });
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.imageUrl),
          ),
          title: Text(
            widget.babysitter_name,
            style: GoogleFonts.workSans(
              color: Colors.black,
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          subtitle: widget.dis! >= 0.0
              ? Text(
                  widget.dis!.toStringAsFixed(2) + " km",
                  style: GoogleFonts.workSans(
                    color: Colors.black,
                    textStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                )
              : null,
          trailing: Icon(
            Icons.arrow_right_sharp,
            size: 26,
          ),
        ),
      ),
    );
  }
}
