import 'package:task/retrofit/local/local_db.dart';

class LocalServices {
  static String getToken() {
    return LocalDB.getString("token");
  }

  static Future removeToken() {
    return LocalDB.removeString("token");
  }


  static bool isUserLoggedIn() {
    if (LocalDB.getString("token").isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}