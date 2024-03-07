import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static  SharedPreferences? prefs;

  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs != null;
  }
}
class TokenManager {
  static const _tokenKey = 'access_Token';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}
