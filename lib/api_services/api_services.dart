import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../utilities/shared_preferences.dart';

final logger = Logger(); // Create an instance of the logger

class ApiService {
  final String baseUrl;
  final Dio dio;

  ApiService(this.baseUrl) : dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> signIn(String username, String password) async {
    try {
      final response = await dio.post(
        '/Userlogin',
        data: jsonEncode({'username': username, 'password': password}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Decode the response body
        final Map<String, dynamic> responseData = response.data;

        // Check if the "ObjLoginDetails" key is present in the response
        if (responseData.containsKey('ObjLoginDetails')) {
          final Map<String, dynamic> userDetails = responseData['ObjLoginDetails'];

          // Check if the "Status" key is present in userDetails
          if (userDetails.containsKey('Status')) {
            String status = userDetails['Status'];

            // Check if the status indicates successful login
            if (status == 'Login Successfully.') {
              final int registrationId = userDetails['RegistrationId'];
              final String name = userDetails['Name'];
              final String email = userDetails['Email'];

              // Use logger for logging user details
              logger.d('User Details: RegistrationId=$registrationId, Name=$name, Email=$email');

              // Depending on your use case, you might want to return true here
              return true;
            } else {
              // Handle other cases (e.g., incorrect status)
              logger.w('Unexpected Status: $status');
            }
          } else {
            // Handle cases where "Status" key is not present in userDetails
            logger.w('Status key not found in userDetails');
          }
        } else {
          // Handle cases where "ObjLoginDetails" key is not present in the response
          logger.w('ObjLoginDetails key not found in API response');
        }
      } else if (response.statusCode == 404) {
        // Handle HTTP 404 error (Endpoint not found)
        logger.e('HTTP Error: 404 - Endpoint not found');
      } else {
        // Handle other HTTP status codes
        logger.e('HTTP Error: ${response.statusCode}');
      }

      // Handle errors or unsuccessful login
      return false;
    } catch (e) {
      // Handle exceptions, if any
      logger.e('Exception during API call: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchDashboardData() async {
    try {
      final String? accessToken = await TokenManager.getToken();

      if (accessToken != null) {
        var url = '$baseUrl/DashboardCustom';
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        };
        var requestBody = {
          "FinId": 1,
          "RegistrationId": 62,
          "LicenceId": 1,
        };

        final response = await dio.post(
          url,
          options: Options(headers: headers),
          data: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          return jsonDecode(response.data);
        } else if (response.statusCode == 401) {
          logger.e('Unauthorized: Token expired or invalid');
        } else {
          logger.e('HTTP Error: ${response.statusCode}');
        }
      } else {
        logger.e('Access token not available');
      }
    } catch (e) {
      logger.e('Exception during API call: $e');
    }

    return {}; // Return an empty map in case of failure
  }
}
