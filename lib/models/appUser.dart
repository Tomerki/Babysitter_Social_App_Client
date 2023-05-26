class appUser {
  final String uid;
  final bool isBabysitter;

  appUser({required this.uid, this.isBabysitter = false});

  String getUid() {
    return uid;
  }

  bool getUserKind() {
    return isBabysitter;
  }
}
