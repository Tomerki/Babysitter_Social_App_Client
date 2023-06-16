import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setLoggedInUser(
      String userId, String userType, String email) async {
    await _preferences.setString('userId', userId);
    await _preferences.setString('userType', userType);
    await _preferences.setString('email', email);
  }

  static String getLoggedInUserId() {
    return _preferences.getString('userId') ?? '';
  }

  static String getLoggedInUserType() {
    return _preferences.getString('userType') ?? '';
  }

  static String getLoggedInUserEmail() {
    return _preferences.getString('email') ?? '';
  }

  static Future<void> clearLoggedInUser() async {
    await _preferences.remove('userId');
    await _preferences.remove('userType');
    await _preferences.remove('email');
  }
}
