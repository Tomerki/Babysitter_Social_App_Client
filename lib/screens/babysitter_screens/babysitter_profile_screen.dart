import 'dart:convert';
import 'package:baby_sitter/models/appUser.dart';
import 'package:baby_sitter/screens/chat_page_screen.dart';
import '../../widgets/babysitter_widgets/babysitter_upper_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/babysitter_widgets/babysitter_middle_page.dart';
import '../../widgets/babysitter_widgets/babysitter_description.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../server_manager.dart';
import '../../services/auth.dart';
import '../../widgets/schedule_with_babysitter.dart';
import 'babysitter_recommendations_screen.dart';

class BabysitterProfileScreen extends StatefulWidget {
  static final routeName = 'BabysitterProfileScreen';
  final String user_body;
  final bool from_search_card;

  const BabysitterProfileScreen(
      {super.key, required this.user_body, this.from_search_card = false});

  @override
  State<BabysitterProfileScreen> createState() =>
      _BabysitterProfileScreenState();
}

class _BabysitterProfileScreenState extends State<BabysitterProfileScreen> {
  String startTime = '';
  String endTime = '';
  bool isFavorite = false;
  int recommendation_len = 0;
  String chatId = "";

  Future<bool> checkDocumentExists() async {
    final collectionRef = await AuthService.firestore
        .collection(AppUser.getUserType())
        .doc(AppUser.getUid())
        .collection('chats');
    final documentRef =
        await collectionRef.doc(json.decode(widget.user_body)['uid']);

    try {
      final snapshot = await documentRef.get();

      if (snapshot.exists) {
        // Document exists
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<String?> getSpecificField() async {
    final collectionRef = await AuthService.firestore
        .collection(AppUser.getUserType())
        .doc(AppUser.getUid())
        .collection('chats');
    final documentRef = collectionRef.doc(json.decode(widget.user_body)['uid']);

    try {
      final documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        // Access a specific field (string) using dot notation
        final fieldValue = documentSnapshot.data()!['chatId'];

        return fieldValue;
      }
    } catch (e) {
      return 'Error';
    }
    return 'Error';
  }

  Future<bool> fetchIsFavorite() async {
    final response =
        await ServerManager().getRequest('items/' + AppUser.getUid(), 'Parent');
    final decodedBody = json.decode(response.body);

    return (decodedBody['favorites'])
        .contains(json.decode(widget.user_body)['uid']);
  }

  Future<int> fetchRecommendationSize() async {
    Map<String, String> is_confirmed_map = {"is_confirmed": "true"};
    var result = await ServerManager().getRequestwithManyParams(
        'get_filter_inner_collection/' +
            json.decode(widget.user_body)['uid'] +
            '/recommendation',
        'Babysitter',
        is_confirmed_map);
    return json.decode(result.body).length;
  }

  @override
  void initState() {
    super.initState();
    if (!AppUser.getUserKind()) {
      fetchIsFavorite().then((value) {
        isFavorite = value;
        setState(() {
          isFavorite = value;
        });
      });
    }
     fetchRecommendationSize().then((value) {
      setState(() {
        recommendation_len = value;
      });
    });
  }

  AppBar build_appBar(var decoded_user_body) {
    return AppBar(
      centerTitle: true,
      title: Text(
        decoded_user_body['fullName'] + ' ' + "Profile",
        style: GoogleFonts.workSans(
          color: Colors.black,
          textStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 129, 100, 110).withOpacity(0.2),
      elevation: 5.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var decoded_user_body = json.decode(widget.user_body);
    MediaQueryData queryData = MediaQuery.of(context);

    return (AppUser.getUid() == decoded_user_body['uid'] &&
            !widget.from_search_card)
        ? SingleChildScrollView(
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                        fit: BoxFit.cover,
                        opacity: 0.3)),
                width: (queryData.size.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            child: Text(
                              "Recommendation",
                              style: GoogleFonts.workSans(
                                color: Colors.white,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor: Colors.black.withOpacity(0.8),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: BabysitterRecommendationScreen(
                                  babysitter_id:
                                      json.decode(widget.user_body)['uid'],
                                ),
                                withNavBar: false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: (queryData.size.height -
                                queryData.padding.top -
                                queryData.padding.bottom) *
                            0.4,
                        child: BabysitterUpperPage(
                          reviews: recommendation_len,
                          pageHight: (queryData.size.height -
                              queryData.padding.top -
                              queryData.padding.bottom),
                          pagewidth: queryData.size.width,
                          name: decoded_user_body['firstName'] +
                              ' ' +
                              decoded_user_body['lastName'],
                          age: decoded_user_body['age'],
                          image: decoded_user_body['image'],
                          address: decoded_user_body['address'] ==
                                  'Africam Safari, Blvd. Capitán Carlos Camacho Espíritu, Oasis, Puebla, Mexico'
                              ? 'No Address'
                              : decoded_user_body['address'],
                          mail: decoded_user_body['email'],
                        ),
                      ),
                    ),
                    Center(
                      child: BabysitterMiddlePage(
                        user_body: widget.user_body,
                        pageHight: (queryData.size.height -
                                queryData.padding.top -
                                queryData.padding.bottom) *
                            0.1,
                        pagewidth: queryData.size.width,
                        price: decoded_user_body['price'] > 0
                            ? decoded_user_body['price'].toString() + '\$\h'
                            : 'unknown price',
                      ),
                    ),
                    BabysitterDescription(
                      pageHight: queryData.size.height - queryData.padding.top,
                      pagewidth: queryData.size.width,
                      description: decoded_user_body['about'],
                    ),
                    !AppUser.getUserKind()
                        ? Container(
                            padding: EdgeInsets.only(top: 5, bottom: 30),
                            child: ScheduleWithaBysitter(
                              parentId: AppUser.getUid(),
                              user_body: widget.user_body,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: build_appBar(decoded_user_body),
            body: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                        fit: BoxFit.cover,
                        opacity: 0.3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              (!AppUser.getUserKind()
                                  ? IconButton(
                                      icon: isFavorite
                                          ? Icon(
                                              Icons.favorite,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                            ),
                                      onPressed: () async {
                                        await ServerManager()
                                            .getRequest(
                                                'search/email/' +
                                                    json.decode(widget
                                                        .user_body)['email'],
                                                'Babysitter')
                                            .then((value) async {
                                          if (!isFavorite) {
                                            await ServerManager()
                                                .updateElementFromArray(
                                                    'add_to_array/' +
                                                        AppUser.getUid(),
                                                    'Parent',
                                                    {
                                                  "field": "favorites",
                                                  "element": json.decode(
                                                      value.body)['uid'],
                                                });
                                          } else {
                                            await ServerManager()
                                                .updateElementFromArray(
                                                    'delete_from_array/' +
                                                        AppUser.getUid(),
                                                    'Parent',
                                                    {
                                                  "field": "favorites",
                                                  "element": json.decode(
                                                      value.body)['uid'],
                                                });
                                          }
                                        });

                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                      },
                                    )
                                  : SizedBox()),
                              IconButton(
                                onPressed: () async {
                                  checkDocumentExists().then((value) async {
                                    if (value) {
                                      final id = await getSpecificField();
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: ChatPageScreen(
                                          secondUid: decoded_user_body['uid'],
                                          chatId: id!,
                                          secondUserType: 'Babysitter',
                                        ),
                                        withNavBar: false,
                                      );
                                    } else {
                                      await AuthService.addChatUser(
                                              decoded_user_body['email'])
                                          .then((value) {
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: ChatPageScreen(
                                            secondUid: decoded_user_body['uid'],
                                            chatId: value,
                                            secondUserType: 'Babysitter',
                                          ),
                                          withNavBar: false,
                                        );
                                      });
                                    }
                                  });
                                },
                                icon: Icon(Icons.message_outlined),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            child: Text(
                              "Recommendation",
                              style: GoogleFonts.workSans(
                                color: Colors.white,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor: Colors.black.withOpacity(0.8),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: BabysitterRecommendationScreen(
                                  babysitter_id:
                                      json.decode(widget.user_body)['uid'],
                                ),
                                withNavBar: false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: (queryData.size.height -
                                queryData.padding.top -
                                -queryData.padding.bottom) *
                            0.4,
                        child: BabysitterUpperPage(
                          reviews: recommendation_len,
                          pageHight: (queryData.size.height -
                              queryData.padding.top -
                              queryData.padding.bottom -
                              AppBar().preferredSize.height),
                          pagewidth: queryData.size.width,
                          name: decoded_user_body['firstName'] +
                              ' ' +
                              decoded_user_body['lastName'],
                          age: decoded_user_body['age'],
                          image: decoded_user_body['image'],
                          address: decoded_user_body['address'] ==
                                  'Africam Safari, Blvd. Capitán Carlos Camacho Espíritu, Oasis, Puebla, Mexico'
                              ? 'No Address'
                              : decoded_user_body['address'],
                          mail: decoded_user_body['email'],
                        ),
                      ),
                    ),
                    Center(
                      child: BabysitterMiddlePage(
                        user_body: widget.user_body,
                        pageHight: (queryData.size.height -
                                queryData.padding.top -
                                queryData.padding.bottom -
                                AppBar().preferredSize.height) *
                            0.15,
                        pagewidth: queryData.size.width,
                        price: decoded_user_body['price'] > 0
                            ? decoded_user_body['price'].toString() + '\$\h'
                            : 'unknown price',
                      ),
                    ),
                    BabysitterDescription(
                      pageHight: (queryData.size.height -
                              queryData.padding.top -
                              queryData.padding.bottom -
                              AppBar().preferredSize.height) *
                          1.2,
                      pagewidth: queryData.size.width,
                      description: decoded_user_body['about'],
                    ),
                    !AppUser.getUserKind()
                        ? Container(
                            padding: EdgeInsets.only(top: 5, bottom: 30),
                            child: ScheduleWithaBysitter(
                              parentId: AppUser.getUid(),
                              user_body: widget.user_body,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ));
  }
}
