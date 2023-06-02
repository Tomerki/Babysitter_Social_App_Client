import 'dart:developer';
import 'dart:io';

import 'package:baby_sitter/models/AppUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/Chat.dart';

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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(Chat chat) {
    return firestore
        .collection(AppUser.getUserType())
        .doc(AppUser.getUid())
        .collection('chats/${getChatID(chat.id)}/messages/')
        .snapshots();
  }

  static Future<String> addChatUser(String email) async {
    final data = await firestore
        .collection(AppUser.getUserType())
        .where('email', isEqualTo: email)
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != connectedUser.uid) {
      //user exists

      log('user exists: ${data.docs.first.data()}');

      firestore
          .collection(AppUser.getUserType())
          .doc(connectedUser.uid)
          .collection('chats')
          .doc(data.docs.first.id)
          .set(data.docs.first.data());

      return data.docs.first.id;
    } else {
      //user doesn't exists

      return "Error";
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firestore
        .collection(AppUser.getUserType())
        .doc(connectedUser.uid)
        .collection('chats')
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('\nUserIds: $userIds');

    return firestore
        .collection(AppUser.getUserType())
        .where('id',
            whereIn: userIds.isEmpty
                ? ['']
                : userIds) //because empty list throws an error
        // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(Chat chat) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chat.id)
        .snapshots();
  }

  static String getConversationID(String id) =>
      connectedUser.uid.hashCode <= id.hashCode
          ? '${connectedUser.uid}_$id'
          : '${id}_${connectedUser.uid}';
}
