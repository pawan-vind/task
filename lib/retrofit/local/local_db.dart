import 'package:hive_flutter/hive_flutter.dart';


class LocalDB {
  static Future saveString(String key, String value) async {
    var box = Hive.box("mainBox");
    return box.put(key, value);
  }

  static String getString(String key) {
    var box = Hive.box("mainBox");
    String value = "";
    if (box.containsKey(key)) {
      value = box.get(key);
    }
    return value;
  }

  static Future removeString(String value) async {
    var box = Hive.box("mainBox");
    return box.delete(value);
  }

}