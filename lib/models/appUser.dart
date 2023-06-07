class AppUser {
  final String uid;
  bool isBabysitter;
  String userType;

  static AppUser? _instance;

  factory AppUser(
      {required String uid, bool isBabysitter = false, String userType = ''}) {
    _instance ??= AppUser._internal(
        uid: uid, isBabysitter: isBabysitter, userType: userType);
    return _instance!;
  }

  AppUser._internal(
      {required this.uid, required this.userType, this.isBabysitter = false});

  static String getUid() {
    return _instance?.uid ?? '';
  }

  static bool getUserKind() {
    return _instance?.isBabysitter ?? false;
  }

  static String getUserType() {
    return _instance?.userType ?? '';
  }

  static void setUserKind(bool kind) {
    _instance?.isBabysitter = kind;
  }

  static void setUserType(String type) {
    _instance?.userType = type;
  }

  static bool isInstanceCreated() {
    return _instance != null;
  }

  static void deleteInstance() {
    _instance = null;
  }

  // Setter method to update the instance
  static void updateInstance({
    required String uid,
    bool isBabysitter = false,
    String userType = '',
  }) {
    _instance = AppUser._internal(
      uid: uid,
      isBabysitter: isBabysitter,
      userType: userType,
    );
  }
}
