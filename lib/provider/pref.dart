import 'package:shared_preferences/shared_preferences.dart';

class PrefProvider {
  static final PrefProvider instance = PrefProvider._internal();
  PrefProvider._internal();

  Future set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  dynamic get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
