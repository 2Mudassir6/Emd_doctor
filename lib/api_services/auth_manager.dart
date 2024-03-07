import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static const String _tokenKey = 'accessToken';

  static Future<void> login(String username, String password) async {
    // Perform actual login process with username and password
    // Send login request to your authentication server
    // Receive response containing access token
    // For example, using your ApiService class
    // final success = await ApiService.login(username, password);

    // Simulate successful login for demonstration purposes
    final success = true;

    if (success) {
      // Save access token to SharedPreferences
      final accessToken = 'sample_access_token'; // Replace with actual token received from server
      await saveToken(accessToken);
    } else {
      throw Exception('Login failed'); // Handle login failure
    }
  }

  static Future<void> refreshToken() async {
    // Perform actual token refresh process
    // Send refresh token request to your authentication server
    // Receive response containing new access token
    // For example, using your ApiService class
    // final newToken = await ApiService.refreshToken();

    // Simulate token refresh for demonstration purposes
    final newToken = 'new_access_token'; // Replace with actual new token received from server

    if (newToken != null) {
      // Save new access token to SharedPreferences
      await saveToken(newToken);
    } else {
      throw Exception('Token refresh failed'); // Handle token refresh failure
    }
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_tokenKey);
    if (jsonString != null) {
      final tokenData = jsonDecode(jsonString);
      return tokenData['access_token'];
    }
    return null;
  }

  static Future<void> logout() async {
    // Perform any necessary cleanup or logout actions
    // For example, clearing stored tokens, session data, etc.
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<bool> isLoggedIn() async {
    // Check if a valid access token exists in SharedPreferences
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static bool isTokenExpired(String? token) {
    if (token == null) return true; // Token is considered expired if it's null
    // Implement token expiration check logic here
    // You may need to parse the token to extract expiration time
    // Compare expiration time with current time to determine if the token is expired
    // For demonstration purposes, assuming token is never expired
    return false;
  }
}
