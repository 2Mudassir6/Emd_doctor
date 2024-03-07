import 'package:flutter/material.dart';


import '../modalwidgets/cat1_cmemodal.dart';
import '../modalwidgets/smmodal.dart';
import '../modalwidgets/t_cmemodal.dart';

class datatable_1 extends StatelessWidget {
  const datatable_1({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 20, // Adjust column spacing
      columns: const [
        DataColumn(
          label: Flexible(
            child: Text(
              'CME Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Flexible(
            child: Text(
              'CME Hr Done/Required',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Flexible(
            child: Text(
              'Action',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(
            Flexible(
              child: Text('Total CME'),
            ),
          ),
          const DataCell(
            Flexible(
              child: Text('35/100'),
            ),
          ),
          DataCell(
            TextButton(
              onPressed: () {
                // Open the modal screen when the button is pressed
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const t_cmemodal(),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                't_cmemodal',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
        DataRow(cells: [
          const DataCell(
            Flexible(
              child: Text('AMA Cat I CME'),
            ),
          ),
          const DataCell(
            Flexible(
              child: Text('35/40'),
            ),
          ),
          DataCell(
            TextButton(
              onPressed: () {
                // Open the modal screen when the button is pressed
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const cat1_cmemodal(),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'cat1_modal',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
        DataRow(cells: [
          const DataCell(
            Flexible(
              child: Text('State Mandatory'),
            ),
          ),
          const DataCell(
            Flexible(
              child: Text('3/3'),
            ),
          ),
          DataCell(
            TextButton(
              onPressed: () {
                // Open the modal screen when the button is pressed
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const DataTableModal(),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'sm_modal',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}