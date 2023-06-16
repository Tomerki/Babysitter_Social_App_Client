// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseService {
//   final String? uid;

//   final FirebaseFirestore usersCollection = FirebaseFirestore.instance;

//   DatabaseService({this.uid});

//   Stream<QuerySnapshot> get users {
//     return usersCollection.collection('Users').snapshots();
//   }

//   Future UpdateUserData(
//       String firstName, String lastName, String phoneNumber) async {
//     try {
//       print("uid inside DatabaseService:");
//       print(uid);
//       await usersCollection.collection('Users').doc(uid).set({
//         'firstName': firstName,
//         'lastName': lastName,
//         'phoneNumber': phoneNumber,
//       });
//     } catch (e) {
//       print('Error updating user data: $e');
//       rethrow; // rethrow the error to the calling function
//     }
//   }
// }
