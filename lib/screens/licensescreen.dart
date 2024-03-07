import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class LicenseManagementScreen extends StatefulWidget {
  const LicenseManagementScreen({super.key});

  @override
  _LicenseManagementScreenState createState() =>
      _LicenseManagementScreenState();
}

class _LicenseManagementScreenState extends State<LicenseManagementScreen> {
  late List<Map<String, dynamic>> licenseData;
  bool isLoading = true; // Add a loading indicator


  @override
  void initState() {
    super.initState();
    fetchLicenseData();
  }

  Future<void> fetchLicenseData() async {
    final url = Uri.parse('http://warals1.ddns.net:8045/api/LicenseDetails');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer MIkslslSn0RWwYjYnqGIjn9Hucw33ou7eGx0_FXXz4KsPJbbsCev1CT6J8PRDwjdmb21DicqNEy7Rk0sCtx4e8Vdn4trZU4QSzwU9kVx9VUy21ejjinKTTRmr5ZG5hdM9I6MuLp_FTnuPVrYB9ZI7aZu5Fy_DfFAzRm1gJL41IH0hYOrDgEArup9IuIv2UiC',
    };
    final body = jsonEncode({'Createdby': 62});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          licenseData = responseData.cast<Map<String, dynamic>>();
          isLoading = false; // Data fetched, set loading to false
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              if (isLoading) // Show a loading indicator while fetching data
                Center(child: CircularProgressIndicator()),
              if (!isLoading && licenseData != null) // Only build table when data is fetched
                Column(
                  children: [
                    const SizedBox(height: 90),
                    Table(
                      defaultColumnWidth: const FlexColumnWidth(1.0),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      border: const TableBorder(
                        horizontalInside: BorderSide.none,
                        verticalInside: BorderSide.none,
                      ),
                      columnWidths: const {
                        5: FlexColumnWidth(2.0),
                        1: FlexColumnWidth(1.5),
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Color(0xFF006FFD)),
                          children: [
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'S.No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'License Name',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total CME Hrs',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'AMA Cat I Hrs',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'AMA Cat II Hrs',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'State Mandatory',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (final data in licenseData)
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data['LicennseId'].toString(),
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['LicenseName'] ?? '',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data['TotalHr']?.toString() ?? '',
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data['MandatoryHr']?.toString() ?? '',
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data['NonMandatoryHr']?.toString() ?? '',
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      data['Topic'] ?? '',
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const YourModalWidget();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Row(
                      children: [
                        Text('Add new'),
                        Icon(Icons.add_circle),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YourModalWidget extends StatefulWidget {
  const YourModalWidget({super.key});

  @override
  _YourModalWidgetState createState() => _YourModalWidgetState();
}

class _YourModalWidgetState extends State<YourModalWidget> {
  String? selectedOption;
  List<String> licenses = [
    'Pennsylvania MD',
    'New Jersey MD'
  ]; // Example list of existing licenses

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'License : ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Add your form fields here, for example:
                // TextFormField(labelText: 'License'),
                const SizedBox(height: 16),
                // Dropdown box
                DropdownButton<String>(
                  value: selectedOption,
                  items: [
                    for (String license in licenses)
                      DropdownMenuItem<String>(
                        value: license,
                        child: Text(license),
                      ),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                  hint: const Text('Select an option'),
                  isExpanded: true,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Close the modal
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(8.0), // Rectangular button
                        ),
                      ),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Check if the selected license already exists
                        if (licenses.contains(selectedOption)) {
                          // Show a dialog indicating the license already exists
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('License Already Exists'),
                                content: const Text(
                                    'The selected license already exists.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Add your logic to handle adding a new license
                          Navigator.pop(context); // Close the modal
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(8.0), // Rectangular button
                        ),
                      ),
                      child: const Text('Add License'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LicenseManagementScreen(),
  ));
}