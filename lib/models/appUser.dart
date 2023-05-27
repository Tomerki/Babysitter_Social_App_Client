// class appUser {
//   final String uid;
//   bool isBabysitter;

//   appUser({required this.uid, this.isBabysitter = false});

//   String getUid() {
//     return uid;
//   }

//   bool getUserKind() {
//     return isBabysitter;
//   }
// }

class AppUser {
  final String uid;
  bool isBabysitter;

  static AppUser? _instance;

  factory AppUser({required String uid, bool isBabysitter = false}) {
    _instance ??= AppUser._internal(uid: uid, isBabysitter: isBabysitter);
    return _instance!;
  }

  AppUser._internal({required this.uid, this.isBabysitter = false});

  static String getUid() {
    return _instance?.uid ?? '';
  }

  static bool getUserKind() {
    return _instance?.isBabysitter ?? false;
  }
}
