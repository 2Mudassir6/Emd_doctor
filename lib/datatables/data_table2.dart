import 'package:flutter/material.dart';

import '../modalwidgets/cat1_cmemodal2.dart';
import '../modalwidgets/smmodal2.dart';
import '../modalwidgets/t_cmemodal2.dart';

class datatable2 extends StatelessWidget {
  const datatable2({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 20,
      columns: const [
        DataColumn(
          label: Text(
            'CME Category',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'CME Hr Done/ Required',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Action',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text('Total CME')),
          const DataCell(Text('35/100')),
          DataCell(
            TextButton(
              onPressed: () {
                // Open the modal screen when the button is pressed
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const t_cmemodal2(),
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
                't_cmemodal2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
        DataRow(cells: [
          const DataCell(Text('AMA Cat I CME')),
          const DataCell(Text('35/20')),
          DataCell(
            TextButton(
              onPressed: () {
                // Open the modal screen when the button is pressed
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const cat1_cmemodal2(),
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
                'cat1_modal2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
        DataRow(cells: [
          const DataCell(Text('State Mandatory')),
          const DataCell(Text('11/12')),
          DataCell(
            TextButton(
              onPressed: () {
                // Open the modal screen when the button is pressed
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const smmodal2(),
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
                'sm_modal2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
