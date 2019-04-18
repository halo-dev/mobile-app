import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static final SPUtil _singleton = SPUtil._internal();

  factory SPUtil() {
    return _singleton;
  }

  SPUtil._internal();

/*
   * 存储数据
   */
  static Future save(String key, String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, date);
  }

/*
   * 读取数据
   */
  static Future get(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }

/*
   * 删除数据
   */
  static Future delete(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
}
