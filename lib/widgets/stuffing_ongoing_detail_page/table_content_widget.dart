import 'package:flutter/material.dart';

class TableContentWidget extends StatelessWidget {
  const TableContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final columnHeaders = [
      'Num',
      'Booking Number',
      'Shipper',
      'Marking',
      'Destination',
      'Cargo Readiness',
      'Qty',
      'Packages',
      'Description of Goods',
      'Gross Weight',
      'Nett Weight',
      'Shipper Meas',
      'Warehouse Meas',
      'Charged Meas',
      'PEB Number',
    ];
    const columnWidths = [
      60.0, 180.0, 150.0, 250.0, 120.0, 130.0, 80.0, 100.0, 300.0, 120.0, 120.0, 120.0, 150.0, 120.0, 150.0
    ];
    // Dummy data, ganti dengan data asli jika perlu
    final stuffingList = [];
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F172A),
          ),
          child: Row(
            children: columnHeaders.asMap().entries.map((entry) {
              final index = entry.key;
              final header = entry.value;
              final width = columnWidths[index];
              return Container(
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: index < columnHeaders.length - 1
                      ? const Border(
                          right: BorderSide(
                            color: Color(0xFF4B5563),
                            width: 1,
                          ),
                        )
                      : null,
                ),
                child: Text(
                  header,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
          ),
        ),
        // Table Rows
        ...stuffingList.asMap().entries.map((entry) {
          final index = entry.key;
          final isEven = index % 2 == 0;
          final rowData = [];
          return Container(
            decoration: BoxDecoration(
              color: isEven ? const Color(0xFFF9FAFB) : Colors.white,
            ),
            child: Row(
              children: rowData.asMap().entries.map((cellEntry) {
                final cellIndex = cellEntry.key;
                final cellData = cellEntry.value;
                final width = columnWidths[cellIndex];
                return Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: cellIndex < rowData.length - 1
                        ? const Border(
                            right: BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    cellData,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: cellIndex == 0 ? FontWeight.w700 : FontWeight.w500,
                      color: cellIndex == 0 ? const Color(0xFF111827) : const Color(0xFF374151),
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ],
    );
  }
}
