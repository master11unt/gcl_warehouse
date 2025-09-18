import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/common_app_bar.dart';
import '../widgets/home/custom_drawer.dart';

class StuffingClearedDetailPage extends StatelessWidget {
  final Map<String, dynamic> stuffingData;
  const StuffingClearedDetailPage({Key? key, required this.stuffingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CommonAppBar(),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Combined Header and Job Details Section
              _buildCombinedHeaderSection(context),
              const SizedBox(height: 24),
              
              // Booking Table Section
              _buildBookingTableSection(),
              const SizedBox(height: 24),
              
              // Status Section
              _buildStatusSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCombinedHeaderSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with back button and title
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF374151),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Stuffing Plan Detail',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Job Details
          _buildDetailRow('Job No', 'GCL-10025091142', isFirst: true),
          _buildDetailRow('Container Number', 'SIKU2243145 / 0059574'),
          _buildDetailRow('Container Size', '20FT'),
          _buildDetailRow('Stuffing Date', '2025-09-01'),
          _buildDetailRow('Estimated Time\nDeparture', '2025-09-04'),
          _buildDetailRow('Closing Date', '2025-09-02'),
          _buildDetailRow('Destination', 'PORT KELANG'),
          _buildDetailRow('Agent', 'ASTSIN', isLast: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isFirst = false, bool isLast = false}) {
    return Column(
      children: [
        if (!isFirst) const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ),
          ],
        ),
        if (!isLast) const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBookingTableSection() {
    final stuffingList = [
      {
        'num': 'A',
        'bookingNumber': 'GTW-20250915031425',
        'shipper': 'TELAGA HARAPAN SEMESTA, PT',
        'marking': 'TELAGA HARAPAN SEMESTA, PT',
        'destination': 'SINGAPORE',
        'cargoReadiness': 'CLEARED',
        'quantity': '18',
        'packages': 'CARTONS',
        'description': 'ELECTRONICS & COMPONENTS',
        'grossWeight': '2,150.300',
        'nettWeight': '2,050.000',
        'shipperMeas': '5.2000',
        'warehouseMeas': '5.0000',
        'chargedMeas': '6.2400',
        'pebNumber': 'PEB-SG-09/2025/3254',
      },
      {
        'num': 'B',
        'bookingNumber': 'GTW-20250914120637',
        'shipper': 'MARITIME LOGISTICS INDO',
        'marking': 'MARITIME LOGISTICS INDO',
        'destination': 'SINGAPORE',
        'cargoReadiness': 'CLEARED',
        'quantity': '25',
        'packages': 'PALLETS',
        'description': 'MACHINERY PARTS & EQUIPMENT',
        'grossWeight': '5,780.420',
        'nettWeight': '5,600.000',
        'shipperMeas': '13.5000',
        'warehouseMeas': '13.2000',
        'chargedMeas': '15.8400',
        'pebNumber': 'PEB-SG-09/2025/3255',
      },
      {
        'num': 'C',
        'bookingNumber': 'GTW-20250913084512',
        'shipper': 'GLOBAL EXPRESS SYSTEMS',
        'marking': 'GLOBAL EXPRESS SYSTEMS',
        'destination': 'SINGAPORE',
        'cargoReadiness': 'CLEARED',
        'quantity': '10',
        'packages': 'BOXES',
        'description': 'AUTOMOTIVE SPARE PARTS',
        'grossWeight': '1,890.150',
        'nettWeight': '1,750.000',
        'shipperMeas': '4.5000',
        'warehouseMeas': '4.3000',
        'chargedMeas': '5.1600',
        'pebNumber': 'PEB-SG-09/2025/3256',
      },
      {
        'num': 'D',
        'bookingNumber': 'GTW-20250912151203',
        'shipper': 'OCEAN FRONTIER CARGO',
        'marking': 'OCEAN FRONTIER CARGO',
        'destination': 'SINGAPORE',
        'cargoReadiness': 'CLEARED',
        'quantity': '32',
        'packages': 'BALES',
        'description': 'TEXTILE & FABRIC MATERIALS',
        'grossWeight': '3,940.680',
        'nettWeight': '3,800.000',
        'shipperMeas': '9.8000',
        'warehouseMeas': '9.5000',
        'chargedMeas': '11.4000',
        'pebNumber': 'PEB-SG-09/2025/3257',
      },
      {
        'num': 'E',
        'bookingNumber': 'GTW-20250911093528',
        'shipper': 'DYNAMIC SHIPPING LINES',
        'marking': 'DYNAMIC SHIPPING LINES',
        'destination': 'SINGAPORE',
        'cargoReadiness': 'CLEARED',
        'quantity': '14',
        'packages': 'CRATES',
        'description': 'INDUSTRIAL TOOLS & EQUIPMENT',
        'grossWeight': '2,650.920',
        'nettWeight': '2,520.000',
        'shipperMeas': '6.8000',
        'warehouseMeas': '6.5000',
        'chargedMeas': '7.8000',
        'pebNumber': 'PEB-SG-09/2025/3258',
      },
    ];

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
      60.0,   // Num
      180.0,  // Booking Number
      150.0,  // Shipper
      250.0,  // Marking
      120.0,  // Destination
      130.0,  // Cargo Readiness
      80.0,   // Quantity
      100.0,  // Packages
      300.0,  // Description of Goods
      120.0,  // Gross Weight
      120.0,  // Nett Weight
      120.0,  // Shipper Meas
      150.0,  // Warehouse Meas
      120.0,  // Charged Meas
      150.0,  // PEB Number
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
          
          const SizedBox(height: 16),
          
          // Horizontal Scrollable Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF374151),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
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
                              child: cellIndex == 5 && cellData == 'CLEARED' 
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6B7280),
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
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status Stuffing',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFF22C55E), width: 1),
                      ),
                      child: const Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF22C55E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Stuffing Instruction',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Standard Stuffing Procedure',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF374151),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stuffing Record',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Stuffing Start',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '2025-08-13\n08:19:02',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF374151),
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Stuffing End',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '2025-08-13\n14:25:18',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF374151),
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}