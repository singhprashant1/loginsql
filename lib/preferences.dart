import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences prefs;

  static String userKey = 'user_key';
  static String mobileUserDetailsKey = 'mobile_user_details_key';

  static void initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setPreferences(String key, String value) {
    //initialize();
    prefs.setString(key, value);
  }

  String getPreferences(String key) {
    //initialize();
    return prefs.getString(key);
  }

// void clearUserType() async {
//     await prefs.remove("username");
//   }
  void clearPreferences() async {
    await prefs.clear();
  }
}
