// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

import 'dashboardui.dart';
import 'forgotpassword.dart';

final logger = Logger();

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
}

// SignInScreen class
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool rememberMe = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ApiService apiService =
  ApiService('http://arizshad-002-site18.atempurl.com/api/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'images/stethoscope.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 330,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color.fromRGBO(233, 236, 239, 1.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(12, 26, 33, 1.0),
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      labelText: 'Username *',
                      labelStyle: TextStyle(fontSize: 18),
                      hintText: 'Enter Username',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      labelText: 'Password *',
                      labelStyle: TextStyle(fontSize: 18),
                      hintText: 'Enter Password',
                    ),
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Retrieve username and password from controllers
                        String username = usernameController.text;
                        String password = passwordController.text;

                        // Make API call using ApiService
                        final bool signedIn = await apiService.signIn(username, password);

                        if (signedIn) {
                          // Navigate to the Dashboard page on successful sign-in
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ),
                          );
                        } else {
                          // Handle sign-in failure
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sign-in failed. Please check your credentials.'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(12, 224, 122, 1.0),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                      // Add your forgot password logic here
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Do you have an account?',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


