import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String userLoggedInkey = "LOGGEDINKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String usernamekey = "USERNAMEKEY";
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInkey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSf(String username) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(usernamekey, username);
  }

  static Future<bool> saveUserEmailSf(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool?> getUserLoggedInstatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInkey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(usernamekey);
  }
}
