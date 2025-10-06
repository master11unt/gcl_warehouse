import 'package:flutter/material.dart';

class BookingTableSectionWidget extends StatelessWidget {
  final List<Map<String, String>> stuffingList;
  const BookingTableSectionWidget({Key? key, required this.stuffingList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const columnHeaders = [
      'Num',
      'Booking Number',
      'Shipper',
      'Marking',
      'Destination',
      'Cargo Readiness',
      'Quantity',
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stuffing Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
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
                    Column(
                      children: stuffingList.asMap().entries.map((entry) {
                        final rowIndex = entry.key;
                        final item = entry.value;
                        final isLastRow = rowIndex == stuffingList.length - 1;
                        final rowData = [
                          item['num']!,
                          item['bookingNumber']!,
                          item['shipper']!,
                          item['marking']!,
                          item['destination']!,
                          item['cargoReadiness']!,
                          item['quantity']!,
                          item['packages']!,
                          item['description']!,
                          item['grossWeight']!,
                          item['nettWeight']!,
                          item['shipperMeas']!,
                          item['warehouseMeas']!,
                          item['chargedMeas']!,
                          item['pebNumber']!,
                        ];
                        return Container(
                          decoration: BoxDecoration(
                            color: rowIndex % 2 == 0 ? Colors.white : const Color(0xFFF9FAFB),
                            border: isLastRow ? null : const Border(
                              bottom: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            ),
                            borderRadius: isLastRow ? const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ) : null,
                          ),
                          child: Row(
                            children: rowData.asMap().entries.map((cellEntry) {
                              final cellIndex = cellEntry.key;
                              final cellData = cellEntry.value;
                              final width = columnWidths[cellIndex];
                              return Container(
                                width: width,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                                child: cellIndex == 5 && cellData == 'READY' 
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF10B981),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          cellData,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : Text(
                                        cellData,
                                        style: TextStyle(
                                          fontSize: cellIndex == 0 ? 14 : 12,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
