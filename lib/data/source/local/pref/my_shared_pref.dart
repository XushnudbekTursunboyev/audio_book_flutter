
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static late final SharedPreferences _pref;

  static void init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static void setRegister(bool value) {
    _pref.setBool("isRegistered", value);
  }

  static bool? isRegister() {
    return _pref.getBool("isRegistered");
  }

  static void setEmail(String email) {
    _pref.setString('email', email);
  }

  static String? getEmail() {

    return _pref.getString('email');
  }

  static void setUsername(String username) {
    _pref.setString('username', username);
  }

  static String? getUserName() {
    return _pref.getString('username');
  }

  static void setFullName(String fullName) {
    _pref.setString('fullName', fullName);
  }

  static String? getFullName() {
    return _pref.getString('fullName');
  }

  static void setAvatar(String img) {
    _pref.setString('img', img);
  }

  static String? getAvatar() {
    return _pref.getString('img');
  }

  static void setTheme(bool value) {
    _pref.setBool('theme', value);
  }

  static bool? getTheme() {
    return _pref.getBool('theme');
  }
}