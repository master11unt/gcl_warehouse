import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/common_app_bar.dart';
import '../widgets/home/custom_drawer.dart';




class StuffingOngoingDetailPage extends StatelessWidget {
  final Map<String, dynamic> stuffingData;
  const StuffingOngoingDetailPage({Key? key, required this.stuffingData}) : super(key: key);

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
              Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'Stuffing Plan Detail',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
StuffingDetailInfoCard(
  info: const [
    {'label': 'Job No', 'value': 'GCL-10025081107'},
    {'label': 'Container Number', 'value': 'SIKU2229050 / 0059774'},
    {'label': 'Container Size', 'value': '20FT'},
    {'label': 'Stuffing Date', 'value': '2025-08-29'},
    {'label': 'Estimated Time Departure', 'value': '2025-09-03'},
    {'label': 'Closing Date', 'value': '2025-08-30'},
    {'label': 'Destination', 'value': 'SINGAPORE'},
    {'label': 'Agent', 'value': 'BENKEL'},
  ],
),
              const SizedBox(height: 24),
              // Tabel detail stuffing dengan horizontal scroll
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
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
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(const Color(0xFF374151)),
                    columns: const [
                      DataColumn(label: Text('Num', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Booking Number', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Shipper', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Description of Goods', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Destination', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Quantity', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Packages', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Marking', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Gross Weight', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Nett Weight', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Shipper Meas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Warehouse Meas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Meas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Charged Meas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('PEB Number', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('A')),
                        DataCell(Text('GTW-20250901094004')),
                        DataCell(Text('YAMATO INDONESIA FORWADING, PT')),
                        DataCell(Text('PRINTED CIRCUIT BOARD')),
                        DataCell(Text('MANILA')),
                        DataCell(Text('5')),
                        DataCell(Text('PALLETS')),
                        DataCell(Text('GIVAUDAN/UNIVERSAL ROBINA CORPORATION')),
                        DataCell(Text('2,000.000')),
                        DataCell(Text('1,500.000')),
                        DataCell(Text('4.0000')),
                        DataCell(Text('-')),
                        DataCell(Text('-')),
                        DataCell(Text('-')),
                        DataCell(Text('N')),
                      ]),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 16),
              // _buildStatusSection(),
            ],
          ),
        ),
      ),
    );
  }
  
  // Simple StuffingDetailInfoCard widget definition
  }
  
  class StuffingDetailInfoCard extends StatelessWidget {
    final List<Map<String, String>> info;
    const StuffingDetailInfoCard({Key? key, required this.info}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: info.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        item['label'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(item['value'] ?? ''),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }











