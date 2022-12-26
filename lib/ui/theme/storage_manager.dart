import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? valueThemeName = prefs.getString(key);
    return valueThemeName;
  }
}
