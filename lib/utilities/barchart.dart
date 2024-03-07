import 'dart:convert';

import 'package:http/http.dart' as http;
import 'app_colors.dart'; // Importing app colors from a custom resource file
import 'package:fl_chart/fl_chart.dart'; // Importing FL Chart library
import 'package:flutter/material.dart'; // Importing Flutter material UI library

class BarChartSample1 extends StatefulWidget {
  // Defining a stateful widget for the bar chart
  BarChartSample1({super.key});

  final Color barBackgroundColor = AppColors.contentColorBlue
      .withOpacity(0.7); // Background color for the bars
  final Color barColor =
      AppColors.contentColorGreen; // Default color for the bars
  final Color touchedBarColor = AppColors.contentColorGreen
      .withOpacity(0.7); // Color for the touched bars

  @override
  State<StatefulWidget> createState() =>
      BarChartSample1State(); // Creating the state for the widget
}

class BarChartSample1State extends State<BarChartSample1> {
  // State class for the bar chart widget
  final Duration animDuration =
  const Duration(milliseconds: 300); // Animation duration for the chart
  int touchedIndex = -5; // Index of the touched bar

  // Variables to store fetched data
  late int totalHours;
  late double totalHoursDone;
  late int stateMandatedHours;
  late double stateMandatedHoursDone;
  late int amaCat1Hours;
  late double amaCat1HoursDone;



  // Function to fetch data from API
  Future<void> fetchData() async {
    final String apiUrl = 'http://warals1.ddns.net:8045/api/DashboardCustom';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> requestBody = {
      "RegistrationId": 48, // Use storeduserId here
      "LicenceId": 1
    };

    final http.Response response =
    await http.post(Uri.parse(apiUrl), headers: headers, body: jsonEncode(requestBody));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> responseData = data.isNotEmpty ? data.first : {};

      // Parse fetched data
      setState(() {
        totalHours = int.parse(responseData['TotalHr']);
        totalHoursDone = double.parse(responseData['TotalHrDone'].toString());
        stateMandatedHours = int.parse(responseData['StateMandatedHrs']);
        stateMandatedHoursDone = double.parse(responseData['StateMandatedHrsDone'].toString());
        amaCat1Hours = int.parse(responseData['AMACat1Hr']);
        amaCat1HoursDone = double.parse(responseData['AMACat1HrDone'].toString());
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data on initialization
  }

  @override
  Widget build(BuildContext context) {
    // Building the UI for the widget
    return Container(
      color: Colors.white10,
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      _buildButton(Colors.blue), // Blue button
                      const SizedBox(
                          height: 12), // Space between button and bar chart
                      const Text(
                        'CME HRS REQUIRED',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      _buildButton(Colors.lightGreenAccent), // Green button
                      const SizedBox(
                          height: 12), // Space between button and bar chart
                      const Text(
                        'CME HRS TAKEN',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BarChart(
                    mainBarData(), // Displaying main data
                    swapAnimationDuration:
                    animDuration, // Setting animation duration
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Function to create BarChartGroupData objects
  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color? barColor,
        double width = 12,
        List<int> showTooltips = const [],
      }) {
    late String label;
    switch (x) {
      case 0:
        label = 'Total Hr';
        break;
      case 1:
        label = 'AMA CAT-1';
        break;
      case 2:
        label = 'State Mandated';
        break;
      default:
        label = ''; // Default label
        break;
    }

    // Additional bars rising from x-axis
    List<BarChartRodData> barRods = [
      BarChartRodData(
        fromY: 0, // Start from the x-axis
        toY: y, // Height of the bar
        color: Colors.lightBlueAccent, // Color of the bar
        width: width, // Width of the bar
      ),
      BarChartRodData(
        fromY: 0, // Start from the x-axis
        toY: y * 2, // Height of the bar
        color: Colors.greenAccent, // Color of the bar
        width: width, // Width of the bar
      ),

    ];

    return BarChartGroupData(
      x: x, // X coordinate of the group
      barRods: barRods,
      showingTooltipIndicators: showTooltips, // Showing tooltips for the bars
    );
  }

  // Function to generate BarChartGroupData objects for each group
  List<BarChartGroupData> showingGroups() => List.generate(3, (i) {
    switch (i) {
      case 0:
        return makeGroupData(i, 62,
            isTouched:
            i == touchedIndex); // Creating group data for index 0
      case 1:
        return makeGroupData(i, 76,
            isTouched:
            i == touchedIndex); // Creating group data for index 1
      case 2:
        return makeGroupData(i, 90,
            isTouched:
            i == touchedIndex); // Creating group data for index 2
      default:
        return throw Error(); // Handling default case
    }
  });

  // Function to create the main bar chart data
  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String label;
            switch (group.x.toInt()) {
              case 0:
                label = 'TotalHr Done';
                break;
              case 1:
                label = 'AMA CAT-1 Done';
                break;
              case 2:
                label = 'State Mandate Done';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$label\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
      ),


      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(), // Setting bar groups
      gridData: const FlGridData(show: false), // Grid data for the chart
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );
    late Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total', style: style),
              Text(' Hr', style: style),
            ],
          ),
        );
        break;
      case 1:
        text = const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('AMA', style: style),
              Text(' CAT-1', style: style),
            ],
          ),
        );
        break;
      case 2:
        text = const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('State', style: style),
              Text(' Mandated', style: style),
            ],
          ),
        );
        break;
      default:
        text = const Text('', style: style); // Setting default title
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 15,
      child: text,
    );
  }

  Widget _buildButton(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
