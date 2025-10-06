import 'package:flutter/material.dart';
import '../widgets/home/custom_drawer.dart';
import '../models/stuffing_data.dart';

class StuffingClearedDetailPage extends StatelessWidget {
  final Map<String, dynamic> stuffingData;
  const StuffingClearedDetailPage({Key? key, required this.stuffingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: CustomDrawer(currentPage: "stuffing"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Combined Header, Job Details and Table Section
              _buildMainContentSection(context),
              const SizedBox(height: 16),
              
              _buildStatusSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value, IconData icon, String text) {
    return PopupMenuItem<String>(
      value: value,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'send_email':
        print('Send Email selected');
        break;
      case 'call_support':
        print('Call Support selected');
        break;
      case 'data':
        print('Data selected');
        break;
      case 'open_mark':
        print('Open Mark selected');
        break;
      case 'print':
        print('Print selected');
        break;
      default:
        break;
    }
  }

  Widget _buildMainContentSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF0F172A),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                Expanded(
                  child: Text(
                    "Stuffing Plan Detail",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width < 400 ? 18 : 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF0F172A)),
                  color: const Color(0xFF0F172A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  offset: const Offset(0, 45),
                  onSelected: (String value) {
                    _handleMenuAction(value);
                  },
                  itemBuilder: (BuildContext context) => [
                    _buildPopupMenuItem('send_email', Icons.send_outlined, 'Send Email'),
                    _buildPopupMenuItem('call_support', Icons.support_agent, 'Call Support'),
                    _buildPopupMenuItem('data', Icons.description_outlined, 'Data'),
                    _buildPopupMenuItem('open_mark', Icons.tag, 'Open Mark'),
                    _buildPopupMenuItem('print', Icons.print_outlined, 'Print'),
                  ],
                ),
              ],
            ),
          ),
          
          // Divider line
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: const Color(0xFFE5E7EB),
          ),
          
          // Job Details Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildDetailRow('Job No', 'GCL-10025091142')),
                    const SizedBox(width: 24),
                    Expanded(child: _buildDetailRow('Container Number', 'SIKU2243145 / 0059574')),
                  ],
                ),
                const SizedBox(height: 20),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildDetailRow('Container Size', '20FT')),
                    const SizedBox(width: 24),
                    Expanded(child: _buildDetailRow('Stuffing Date', '2025-09-01')),
                  ],
                ),
                const SizedBox(height: 20),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildDetailRow('Estimated Time\nDeparture', '2025-09-04')),
                    const SizedBox(width: 24),
                    Expanded(child: _buildDetailRow('Closing Date', '2025-09-02')),
                  ],
                ),
                const SizedBox(height: 20),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildDetailRow('Destination', 'PORT KELANG')),
                    const SizedBox(width: 24),
                    Expanded(child: _buildDetailRow('Agent', 'ASTSIN')),
                  ],
                ),
              ],
            ),
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
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
                      child: _buildTableContent(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableContent() {
    final stuffingList = StuffingData.getDummyClearedTable();

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

    return Column(
      children: [
        // Table Header
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
          final item = entry.value;
          final isEven = index % 2 == 0;
          
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

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
                fontStyle: FontStyle.italic,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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