import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
// Create a Logger instance
Logger logger = Logger();

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key});

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FocusNode _oldPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    _oldPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Update Your Password.',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _oldPasswordController,
                            focusNode: _oldPasswordFocus,
                            decoration: InputDecoration(
                              labelText: 'Old Password',
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your old password.';
                              }
                              // Replace 'your_stored_old_password' with the actual stored old password
                              if (value != 'your_stored_old_password') {
                                return 'Old password does not match.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Enter your old password.',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextFormField(
                        controller: _newPasswordController,
                        focusNode: _newPasswordFocus,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new password.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password.';
                          }
                          if (value != _newPasswordController.text) {
                            return 'New password and confirm password do not match.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Call your API here
                          final response = await http.post(
                            Uri.parse('http://warals1.ddns.net:8045/api/UpdatePassword'),
                            body: {
                              'oldPassword': _oldPasswordController.text,
                              'newPassword': _newPasswordController.text,
                            },
                          );

                          if (response.statusCode == 200) {
                            // Password updated successfully
                            // You can handle the response here
                            logger.i('Password updated successfully');
                          } else {
                            // Handle errors here
                            logger.e('Failed to update password. Status code: ${response.statusCode}');
                          }
                        }
                      }
                      ,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
