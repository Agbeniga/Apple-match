import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static late SharedPreferences prefs;

  static set isRegistered(bool isRegistered) =>
      prefs.setBool("isRegistered", isRegistered);
  static bool get isRegistered =>
      prefs.getBool("isRegistered") ?? false;
  static set accessToken(String accessToken) => prefs.setString("accessToken", accessToken);
  static String get accessToken => prefs.getString("accessToken") ?? "";

  static set isFirstLaunch(bool isFirstLaunch) =>
      prefs.setBool("isFirstLaunch", isFirstLaunch);
  static bool get isFirstLaunch => prefs.getBool("isFirstLaunch") ?? true;

  static set isloggedIn(bool isloggedIn) =>
      prefs.setBool("isloggedIn", isloggedIn);
  static bool get isloggedIn => prefs.getBool("isloggedIn") ?? false;

 
  //* AppUser
  static set appUser(String appUser) => prefs.setString("appUser", appUser);
  static String get appUser => prefs.getString("appUser") ?? '';

  static set email(String email) => prefs.setString("email", email);
  static String get email => prefs.getString("email") ?? '';

  //* password
  static set password(String password) => prefs.setString("password", password);
  static String get password => prefs.getString("password") ?? '';

  static void clear() {
    PreferenceManager.isFirstLaunch = false;
    PreferenceManager.isloggedIn = false;
  }

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
