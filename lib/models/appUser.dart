class appUser {
  final String uid;
  bool isBabysitter;

  appUser({required this.uid, this.isBabysitter = false});

  String getUid() {
    return uid;
  }

  bool getUserKind() {
    return isBabysitter;
  }
}
