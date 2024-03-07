import 'package:flutter/material.dart';

class smmodal2 extends StatelessWidget {
  const smmodal2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Topic')),
                    DataColumn(label: Text('Credit Hour')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Certificate')),
                    DataColumn(label: Text('Receipt')),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Risk Management' )),
                        const DataCell(Text('8.00')),
                        const DataCell(Text('15/09/2023')),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              // Action when button in column 4 is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('View'),
                          ),
                        ),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              // Action when button in column 5 is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('View'),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Child Abuse Identification and Reporting')),
                        const DataCell(Text('2.00')),
                        const DataCell(Text('21/09/2023')),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              // Action when button in column 4 is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('View'),
                          ),
                        ),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              // Action when button in column 5 is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('View'),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Responsible and Effective Opioid Prescribing')),
                        const DataCell(Text('1.00')),
                        const DataCell(Text('19/09/2023')),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              // Action when button in column 4 is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('View'),
                          ),
                        ),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              // Action when button in column 5 is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('View'),
                          ),
                        ),
                      ],
                    ),
                    // DataRow(
                    //   cells: <DataCell>[
                    //     DataCell(Text('Responsible and Effective Opioid Prescribing')),
                    //     DataCell(Text('1.00')),
                    //     DataCell(Text('19/09/2023')),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 4 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 5 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // DataRow(
                    //   cells: <DataCell>[
                    //     DataCell(Text('Risk Management')),
                    //     DataCell(Text('8.00')),
                    //     DataCell(Text('15/09/2023')),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 4 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 5 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // DataRow(
                    //   cells: <DataCell>[
                    //     DataCell(Text('Child Abuse Identification and Reporting')),
                    //     DataCell(Text('2.00')),
                    //     DataCell(Text('21/09/2023')),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 4 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 5 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // DataRow(
                    //   cells: <DataCell>[
                    //     DataCell(Text('Assessment and Management of Pain at the End of Life')),
                    //     DataCell(Text('2.00')),
                    //     DataCell(Text('23/09/2023')),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 4 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 5 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // DataRow(
                    //   cells: <DataCell>[
                    //     DataCell(Text('22')),
                    //     DataCell(Text('23')),
                    //     DataCell(Text('24')),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 4 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //     DataCell(
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Action when button in column 5 is pressed
                    //         },
                    //         child: Text('View'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Add more DataRow widgets for additional rows if needed
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}