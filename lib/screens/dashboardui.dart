import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../datatables/data_table1.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../datatables/data_table2.dart';
import '../utilities/barchart.dart';
import '../utilities/barchart2.dart';

final logger = Logger(); // Create an instance of the logger

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _selectedYear = 'Select an item';
  String licenseName = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchDataFromDashboardCustom();
  }

  Future<void> fetchDataFromDashboardCustom() async {
    try {
      final String? accessToken = await _getAccessToken();

      if (accessToken != null) {
        var url = 'http://arizshad-002-site18.atempurl.com/api/DashboardCustom';
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        };
        var requestBody = {
          "FinId": "",
          "RegistrationId": "",
          "LicenceId": "",
        };
        var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonEncode(requestBody));

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          if (responseData != null && responseData.isNotEmpty) {
            setState(() {
              licenseName = responseData[0]["LicenseName"];
            });
          }
        } else if (response.statusCode == 401) {
          // Token expired, prompt user to log in again or refresh token
          // Implement token refresh mechanism here
          // For now, let's assume the token is refreshed and retry the request
          // FetchDataFromDashboardCustom();
        } else {
          print('Request failed with status: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } else {
        // Token not available, prompt user to log in
        // Navigate to login screen
        // Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTimeString = prefs.getString('expiry_time');
    if (expiryTimeString != null) {
      final expiryTime = DateTime.parse(expiryTimeString);
      if (DateTime.now().isBefore(expiryTime)) {
        return prefs.getString('access_token');
      } else {
        // Token expired, prompt user to log in again or refresh token
        // Implement token refresh mechanism here
        // For now, let's assume the token is refreshed and return the new token
        // ReturnNewToken();
      }
    }
    return null;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myAppBarBackgroundColor,
        title: myAppBarTitle,
        leading: myAppBarLeading,
        actions: myAppBarActions,
      ),
      drawer: myDrawer,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20), // Add spacing below the app bar
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40, // Adjust font size as needed
                ),
              ),
            ),
            const SizedBox(height: 20), // Add spacing between the heading and chart
            // Move the container with text and dropdown button here
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      licenseName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedYear,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedYear = newValue!;
                          });
                        },
                        items: <String>['Select an item', '2023-24']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Add spacing between the dropdown and the chart
            Padding(
              padding: const EdgeInsets.all(16),
              child: BarChartSample1(), // Use the DualBarChart widget here
            ),
            const SizedBox(height: 20), // Add spacing between the chart and table
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200, // Adjust the height of the table
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: datatable_1(),//first data table is called over here
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Add spacing between the table and the headline
                  const Text(
                    '*State Mandated should be AMA CAT I',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Add spacing between the headline and the blue box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            'Pennsylvania MD(Jan 1, 2023 - Dec 31, 2024)',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10), // Add some space between text and dropdown button
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedYear,
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedYear = newValue!;
                                });
                              },
                              items: <String>['Select an item', '2023-24']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  // Add spacing between buttons and the dual barchart
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: BarChartSample2(), // Add the dual barchart here
                  ),
                  const SizedBox(height: 20),
                  // Add spacing between the dual barchart and the table
                  Container(
                    height: 200, // Adjust the height of the table
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: datatable2()
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Add spacing between the table and the headline
                  const Text(
                    '*State Mandated should be AMA CAT I',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}