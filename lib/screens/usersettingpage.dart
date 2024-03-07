import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart'; // Importing constants.dart which contains predefined app bar and drawer widgets

var logger = Logger(); // Creating an instance of Logger from the logger package

// Widget for the user settings page
class UserSettingPage extends StatefulWidget {
  const UserSettingPage({super.key,});

  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String _selectedWeekday = 'Select Weekday';
  String? _selectedTime = 'Select Time';
  String? _selectedTimezone; // Instead of 'Select Timezone'

  bool isEditing = false; // Flag to track whether the user is in edit mode

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // Function to reset all the fields to their initial values
  void resetFields() {
    setState(() {
      _selectedWeekday = 'Select Weekday';
      _selectedTime = 'Select Time';
      _selectedTimezone = null;
    });
  }

  // Function to make a GET request to fetch user data from your API
  Future<void> fetchDataFromApi() async {
    try {
      final response = await http.post(
        Uri.parse('http://arizshad-002-site18.atempurl.com/api/GetUser'), // API endpoint for fetching user data
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ZVnCuPrQGgrn3q20SXq_jQAM43Bv3HSMBWynJ3IdYhGDe-X1b0FPxaNKy-zU5eMPK23NosjU5hspow_hzWLBy1Bz7OWGr00bqkE12dhSKjobJlN0EywmfB4g5hlToOJA2gQDTxT5Nw6HwIiJ2x9SeDo4gJvZQ2r2p02_Rs2QmXmNh7DPJvKsEcyko_u8OvcLrDzWEyDSrhGPL5okDvedOA', // Authorization token
        },
        body: jsonEncode({
          "RegistrationId": 48,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)[0];
        setState(() {
          firstNameController.text = data['FName'] ?? ''; // Changed to FName
          lastNameController.text = data['LName'] ?? ''; // Changed to LName
          emailController.text = data['Email'] ?? ''; // Changed to Email
        });
      } else {
        logger.e('Error: ${response.statusCode}');
      }
    } catch (error) {
      logger.e('Network error: $error');
    }
  }

  // Function to make a POST request to update user data
  Future<void> updateDataToApi() async {
    try {
      final response = await http.post(
        Uri.parse('http://warals1.ddns.net:8045/api/GetUser'), // API endpoint for updating user data
        headers: {
          'Authorization': 'Bearer AQhgIsDWWLIAVFCYXQmugi4jj8YAe5P1QpscsCJH5FXvtYZSnETPmASoTtRkswtJQE3-Ix2IbZmvYbUzn0XzNuX0VJ9fVltUFHmHIZCTFnArq-a9-nXleIrCEzWMEoTxYgFm8eUCIJJ9K28apfgVWCMKcx8KLeZn1rL9RCUTOqmGTB0B85Ph2t6ZOgo4nOnu', // Authorization token
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'FName':  firstNameController.text,
          'LName': lastNameController.text,
          'Email': emailController.text,
        }),
      );

      if (response.statusCode == 200) {
        logger.d('API Response: ${response.body}');
      } else {
        logger.e('Error: ${response.statusCode}');
      }
    } catch (error) {
      logger.e('Network error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi(); // Fetch initial user data when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar, // Using the AppBar from constants.dart
      drawer: myDrawer, // Using the Drawer from constants.dart
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile Update:',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50.0),
            buildInputField(firstNameController), // Building input field for doctor
            const SizedBox(height: 5.0),
            buildInputField(lastNameController), // Building input field for number
            const SizedBox(height: 10.0),
            buildEmailVerificationSection(emailController), // Building email verification section
            const SizedBox(height: 20.0),
            buildEditButton(), // Building edit button
            const SizedBox(height: 20.0),
            const Divider(
              thickness: 2.0,
              color: Colors.black,
            ), //divider is that black line to divide the page into two
            const SizedBox(height: 10.0),
            // Widgets below the divider
            LicenseReminderForm(
              selectedWeekday: _selectedWeekday,
              selectedTime: _selectedTime,
              selectedTimezone: _selectedTimezone,
              onWeekdayChanged: (value) {
                setState(() {
                  _selectedWeekday = value!;
                });
              },
              onTimeChanged: (value) {
                setState(() {
                  _selectedTime = value;
                });
              },
              onTimezoneChanged: (value) {
                setState(() {
                  _selectedTimezone = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Building input field widget
  Widget buildInputField(TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextField(
          controller: controller,
          enabled: isEditing,
          decoration: const InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  // Building email verification section widget
  Widget buildEmailVerificationSection(TextEditingController controller) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: TextField(
            controller: controller,
            enabled: isEditing,
            decoration: const InputDecoration(
              labelText: 'Enter Email',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            // Verify email logic
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            textStyle: const TextStyle(fontSize: 20),
          ),
          child: const Text(
            'VERIFY',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  // Building edit button widget
  Widget buildEditButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: isEditing
          ? Row(
        children: [
          ElevatedButton(
            onPressed: () {
              // Call the API function when the button is pressed
              updateDataToApi();
              setState(() {
                isEditing = false; // Save changes logic
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
            child: const Text('Save Changes'),
          ),
          const SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isEditing = false; // Cancel changes logic
                resetFields(); // Reset the fields when cancelling
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            child: const Text('Cancel'),
          ),
        ],
      )
          : ElevatedButton(
        onPressed: () {
          setState(() {
            isEditing = true; // Toggle the editing state
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(fontSize: 18),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
        ),
        child: const Text('Edit'),
      ),
    );
  }
}

// Widget for the license reminder form
class LicenseReminderForm extends StatefulWidget {
  final String selectedWeekday;
  final String? selectedTime;
  final String? selectedTimezone;
  final ValueChanged<String?> onWeekdayChanged;
  final ValueChanged<String?> onTimeChanged;
  final ValueChanged<String?> onTimezoneChanged;

  const LicenseReminderForm({
    super.key,
    required this.selectedWeekday,
    required this.selectedTime,
    required this.selectedTimezone,
    required this.onWeekdayChanged,
    required this.onTimeChanged,
    required this.onTimezoneChanged,
  });

  @override
  _LicenseReminderFormState createState() => _LicenseReminderFormState();
}

class _LicenseReminderFormState extends State<LicenseReminderForm> {
  // Function to show dialog indicating successful save
  void _showSavedSuccessfullyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Time period saved successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select from the below option when you want the reminder of license expiry:',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 40.0),
          _buildTimePicker(),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Save functionality
                  _showSavedSuccessfullyDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onWeekdayChanged('Select Weekday');
                  widget.onTimeChanged('Select Time');
                  widget.onTimezoneChanged('Select Timezone');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Building dropdown widget for selecting weekday
  Widget _buildWeekdayDropdown() {
    return DropdownButtonFormField<String?>(
      value: widget.selectedWeekday,
      items: const [
        DropdownMenuItem(
          value: 'Select Weekday',
          child: Text('Select Weekday'),
        ),
        DropdownMenuItem(
          value: 'Monday',
          child: Text('Monday'),
        ),
        DropdownMenuItem(
          value: 'Tuesday',
          child: Text('Tuesday'),
        ),
        DropdownMenuItem(
          value: 'Wednesday',
          child: Text('Wednesday'),
        ),
        DropdownMenuItem(
          value: 'Thursday',
          child: Text('Thursday'),
        ),
        DropdownMenuItem(
          value: 'Friday',
          child: Text('Friday'),
        ),
        DropdownMenuItem(
          value: 'Saturday',
          child: Text('Saturday'),
        ),
        DropdownMenuItem(
          value: 'Sunday',
          child: Text('Sunday'),
        ),
      ],
      onChanged: (value) {
        widget.onWeekdayChanged(value!);
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        border: OutlineInputBorder(),
      ),
    );
  }

  // Building time picker widget
  Widget _buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBoxWithTitle('Select Weekday:', _buildWeekdayDropdown()),
        const SizedBox(height: 15.0),
        _buildBoxWithTitle(
          'Time:',
          _buildTimeDropdown(),
        ),
        const SizedBox(height: 15.0),
        _buildBoxWithTitle('Select Timezone:', _buildTimezoneDropdown()),
      ],
    );
  }

  // Building dropdown widget for selecting time
  Widget _buildTimeDropdown() {
    List<String> hours = List.generate(24, (index) => index.toString());
    List<String> minutes = List.generate(60, (index) => index.toString());

    return Row(
      children: [
        _buildTimeUnitDropdown(
          title: 'Hours',
          values: hours,
          onChanged: (value) {
            widget.onTimeChanged(
                '$value:${widget.selectedTime?.split(":")[1] ?? '00'}');
          },
        ),
        const SizedBox(width: 10.0),
        _buildTimeUnitDropdown(
          title: 'Minutes',
          values: minutes,
          onChanged: (value) {
            widget.onTimeChanged(
                '${widget.selectedTime?.split(":")[0] ?? '00'}:$value');
          },
        ),
      ],
    );
  }

  // Building dropdown widget for selecting time unit
  Widget _buildTimeUnitDropdown({
    required String title,
    required List<String> values,
    required ValueChanged<String?> onChanged,
  }) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: values.first,
        items: values.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: title,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Building box widget with title
  Widget _buildBoxWithTitle(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
        child,
      ],
    );
  }

  // Building dropdown widget for selecting timezone
  Widget _buildTimezoneDropdown() {
    return DropdownButtonFormField<String?>(
      value: widget.selectedTimezone,
      items: const [
        DropdownMenuItem(
          value: null,
          child: Text('Select Timezone'),
        ),
        DropdownMenuItem(
          value: 'Default',
          child: Text('Default'),
        ),
        DropdownMenuItem(
          value: 'Eastern Standard Time',
          child: Text('Eastern Standard Time'),
        ),
        // Add remaining timezone options ...
      ],
      onChanged: (value) {
        if (value != null) {
          widget.onTimezoneChanged(value);
        }
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        border: OutlineInputBorder(),
      ),
    );
  }
}

// Widget for the settings page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar, // Using the AppBar from constants.dart
      drawer: myDrawer, // Using the Drawer from constants.dart
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LicenseReminderForm(
          selectedWeekday: 'Select Weekday',
          selectedTime: null,
          selectedTimezone: null,
          onWeekdayChanged: (value) {
            // Handle weekday change
          },
          onTimeChanged: (value) {
            // Handle time change
          },
          onTimezoneChanged: (value) {
            // Handle timezone change
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: UserSettingPage(),
  ));
}
