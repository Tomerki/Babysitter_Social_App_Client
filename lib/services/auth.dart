import 'dart:developer';
import 'package:tuple/tuple.dart';
import 'package:baby_sitter/models/appUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndpassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndpassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInAnon() async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future singOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static User get connectedUser => auth.currentUser!;

  static String getChatID(String id) =>
      connectedUser.uid.hashCode <= id.hashCode
          ? '${connectedUser.uid}_$id'
          : '${id}_${connectedUser.uid}';

  static Future<String> addChatUser(String email) async {
    Tuple2<QuerySnapshot<Map<String, dynamic>?>, String>? res =
        await searchUserByEmail(email);
    final data = res!.item1;

    final myData = await firestore
        .collection(AppUser.getUserType())
        .doc(AppUser.getUid())
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != connectedUser.uid) {
      //user exists

      String docId = await firestore.collection('Chats').doc().id;
      await firestore.collection('Chats').doc(docId).collection('Messages');

      final secondUserData = data.docs.first.data();
      final myUserData = myData.data();

      log('user exists: ${data.docs.first.data()}');
      firestore
          .collection(AppUser.getUserType())
          .doc(connectedUser.uid)
          .collection('chats')
          .doc(secondUserData!['uid'])
          .set({
        'lastMessage': 'No Messages yet',
        'lastMessageDate': Timestamp.now(),
        'uid': secondUserData['uid'],
        'fullName': secondUserData['fullName'],
        'userImage': secondUserData['image'],
        'chatId': docId,
      });

      firestore
          .collection(res.item2)
          .doc(secondUserData['uid'])
          .collection('chats')
          .doc(connectedUser.uid)
          .set({
        'lastMessage': 'No Messages yet',
        'lastMessageDate': Timestamp.now(),
        'uid': connectedUser.uid,
        'fullName': myUserData!['fullName'],
        'userImage': myUserData['image'],
        'chatId': docId,
      });

      return data.docs.first.id;
    } else {
      //user doesn't exists

      return "Error";
    }
  }

  static Future<Tuple2<QuerySnapshot<Map<String, dynamic>?>, String>?>
      searchUserByEmail(String email) async {
    // Create references to the two collections
    final CollectionReference<Map<String, dynamic>> collection1 =
        firestore.collection('Parent');
    final CollectionReference<Map<String, dynamic>> collection2 =
        firestore.collection('Babysitter');

    // Query collection1 to find the user with the given email
    final QuerySnapshot<Map<String, dynamic>> query1 =
        await collection1.where('email', isEqualTo: email).get();

    // Query collection2 to find the user with the given email
    final QuerySnapshot<Map<String, dynamic>> query2 =
        await collection2.where('email', isEqualTo: email).get();

    // Check if the user exists in collection1
    if (query1.docs.isNotEmpty) {
      return Tuple2(query1, 'Parent');
    }

    // Check if the user exists in collection2
    if (query2.docs.isNotEmpty) {
      return Tuple2(query2, 'BabySitter');
    }

    // User not found in either collection
    return null;
  }
}
