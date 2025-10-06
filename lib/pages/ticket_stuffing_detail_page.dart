import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/home/custom_drawer.dart';

class TicketStuffingDetailPage extends StatefulWidget {
  final Map<String, dynamic> ticketData;

  const TicketStuffingDetailPage({
    super.key,
    required this.ticketData,
  });

  @override
  State<TicketStuffingDetailPage> createState() => _TicketStuffingDetailPageState();
}

class _TicketStuffingDetailPageState extends State<TicketStuffingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CommonAppBar(),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBreadcrumb(),
              const SizedBox(height: 16),
              
              // Combined Content (Main Content + Stuffing List + Stuffing Instruction)
              _buildCombinedContentCard(),
              const SizedBox(height: 16),
              
              _buildRulesSection(),
              const SizedBox(height: 16),
              
              _buildQRCodeSection(),
              const SizedBox(height: 16),
              
              _buildFooterSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF374151),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          
          // Breadcrumb navigation
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ticket',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF9CA3AF),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Stuffing',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF9CA3AF),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.ticketData['jobNumber'] ?? 'GCL-1002507096',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCombinedContentCard() {
    final stuffingList = [
      {
        'num': 'A',
        'bookingNumber': 'GTW-20250723043916',
        'shipper': 'VAN AROMA',
        'description': 'PATCHOULI OIL DECOL, EUGENOL NAT (UN 3082, CLASS 9, PG III)',
        'destination': 'SHANGHAI',
        'quantity': '4',
        'packages': 'PALLETS',
        'marking': 'SYMRISE FLAVORS & FRAGRANCES (NANTONG) NANJING UNIVIS',
        'grossWeight': '1,629.100',
        'nettWeight': '1,550.000',
        'shipperMeas': '4.0000',
        'warehouseMeas': '3.7190',
        'chargedMeas': '5.5400',
        'pebNumber': '-',
      },
      {
        'num': 'B',
        'bookingNumber': 'GTW-20250718083233',
        'shipper': 'VAN AROMA',
        'description': 'PATCHOULI OIL DECOL, EUGENOL NAT (UN 3082, CLASS 9, PG III)',
        'destination': 'SHANGHAI',
        'quantity': '3',
        'packages': 'PALLETS',
        'marking': 'SYMRISE FLAVORS & FRAGRANCES (NANTONG) NANJING UNIVIS',
        'grossWeight': '1,450.000',
        'nettWeight': '1,380.000',
        'shipperMeas': '3.5000',
        'warehouseMeas': '3.2000',
        'chargedMeas': '4.8000',
        'pebNumber': '-',
      },
      {
        'num': 'C',
        'bookingNumber': 'GTW-20250724111439',
        'shipper': 'NIDEC INSTRUMENT INDONESIA',
        'description': 'SERVO MOTOR & SERVO DRIVE',
        'destination': 'SHANGHAI',
        'quantity': '2',
        'packages': 'CARTONS',
        'marking': 'NIDEC INSTRUMENT INDONESIA',
        'grossWeight': '850.000',
        'nettWeight': '780.000',
        'shipperMeas': '2.5000',
        'warehouseMeas': '2.3000',
        'chargedMeas': '3.2000',
        'pebNumber': '-',
      },
      {
        'num': 'D',
        'bookingNumber': 'GTW-20250725030548',
        'shipper': 'WINFASTSHIP INDONESIA',
        'description': 'ELECTRONIC COMPONENTS',
        'destination': 'SHANGHAI',
        'quantity': '5',
        'packages': 'BOXES',
        'marking': 'WINFASTSHIP INDONESIA',
        'grossWeight': '2,100.000',
        'nettWeight': '2,000.000',
        'shipperMeas': '6.0000',
        'warehouseMeas': '5.8000',
        'chargedMeas': '7.2000',
        'pebNumber': '-',
      },
      {
        'num': 'E',
        'bookingNumber': 'GTW-20250729113101',
        'shipper': 'KLINE LOGIST PT',
        'description': 'INDUSTRIAL MACHINERY PARTS',
        'destination': 'SHANGHAI',
        'quantity': '3',
        'packages': 'PALLETS',
        'marking': 'KLINE LOGIST PT',
        'grossWeight': '1,800.000',
        'nettWeight': '1,720.000',
        'shipperMeas': '4.5000',
        'warehouseMeas': '4.2000',
        'chargedMeas': '5.8000',
        'pebNumber': '-',
      },
      {
        'num': 'F',
        'bookingNumber': 'GTW-20250728030302',
        'shipper': 'LAVA TEXTIL BVBA INDON PT',
        'description': 'TEXTILE MATERIALS',
        'destination': 'SHANGHAI',
        'quantity': '8',
        'packages': 'BALES',
        'marking': 'LAVA TEXTIL BVBA INDON PT',
        'grossWeight': '3,200.000',
        'nettWeight': '3,100.000',
        'shipperMeas': '8.0000',
        'warehouseMeas': '7.5000',
        'chargedMeas': '9.6000',
        'pebNumber': '-',
      },
      {
        'num': 'G',
        'bookingNumber': 'GTW-20250731012027',
        'shipper': 'OCEAN SKY I',
        'description': 'MARINE EQUIPMENT',
        'destination': 'SHANGHAI',
        'quantity': '2',
        'packages': 'CRATES',
        'marking': 'OCEAN SKY I',
        'grossWeight': '1,500.000',
        'nettWeight': '1,400.000',
        'shipperMeas': '3.8000',
        'warehouseMeas': '3.6000',
        'chargedMeas': '4.5000',
        'pebNumber': '-',
      },
    ];

    const columnHeaders = [
      'Num',
      'Booking Number',
      'Shipper',
      'Description of Goods',
      'Destination',
      'Quantity',
      'Packages',
      'Marking',
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
      300.0,  // Description of Goods
      120.0,  // Destination
      80.0,   // Quantity
      100.0,  // Packages
      250.0,  // Marking
      120.0,  // Gross Weight
      120.0,  // Nett Weight
      120.0,  // Shipper Meas
      150.0,  // Warehouse Meas
      120.0,  // Charged Meas
      100.0,  // PEB Number
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
          // Job Number Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Job Number',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.ticketData['jobNumber'] ?? 'GCL-1002507096',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.headset_mic,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Column(
            children: [
              // Row 1: Destination - Stuffing Date
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDetailItemWithHeight('Destination', widget.ticketData['destination'] ?? 'SHANGHAI'),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: _buildDetailItemWithHeight('Stuffing Date', _formatDate(widget.ticketData['stuffingDate'], type: 'stuffingDate'), isStuffingDate: true),
                  ),
                ],
              ),
              
              // Row 2: Container Number - Container Size
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDetailItemWithHeight('Container Number', widget.ticketData['containerNumber'] ?? 'KOCU5009373 / 24H0102212'),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: _buildDetailItemWithHeight('Container Size', widget.ticketData['containerSize'] ?? '40HC'),
                  ),
                ],
              ),
              
              // Row 3: Estimated Time Departure - Closing Date
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDetailItemWithHeight('Estimated Time Departure', _formatDate(widget.ticketData['etd'], type: 'etd')),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: _buildDetailItemWithHeight('Closing Date', _formatDate(widget.ticketData['closingDate'], type: 'closingDate')),
                  ),
                ],
              ),
              
              // Row 4: Vessel - Stuffing Owner
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDetailItemWithHeight('Vessel', widget.ticketData['vessel'] ?? 'HMM MIRACLE V 009N'),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: _buildDetailItemWithHeight('Stuffing Owner', widget.ticketData['stuffingOwner'] ?? 'GCL-JAKARTA'),
                  ),
                ],
              ),
              
              // Row 5: Agent - (empty slot for balance)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDetailItemWithHeight('Agent', widget.ticketData['agent'] ?? 'PORTSHA'),
                  ),
                  const SizedBox(width: 32),
                  const Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Stuffing List Section
          const Text(
            'Stuffing List',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9CA3AF),
              fontStyle: FontStyle.italic,
            ),
          ),
          
          const SizedBox(height: 16),
          
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
                  Column(
                    children: stuffingList.asMap().entries.map((entry) {
                      final rowIndex = entry.key;
                      final item = entry.value;
                      final isLastRow = rowIndex == stuffingList.length - 1;
                      
                      final rowData = [
                        item['num']!,
                        item['bookingNumber']!,
                        item['shipper']!,
                        item['description']!,
                        item['destination']!,
                        item['quantity']!,
                        item['packages']!,
                        item['marking']!,
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
                              child: Text(
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
          
          const SizedBox(height: 32),
          
          const Text(
            'Stuffing Instruction',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9CA3AF),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '*HANDLE CARGO WITH CARE\n**SEBELUM CONTAINER DI SEAL\nPASTIKAN DIGUDANG TIDAK ADA CARGO YANG TERTINGGAL.\n***JAUHKAN CARGO YANG BERBAU DENGAN CARGO GARMENT ATAU SEJENISNYA BELI STIKER DG AGENT PORTSHA',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRulesSection() {
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
            'Rules',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Based On : ${widget.ticketData['rulesReference'] ?? 'GTW/SOP/JKT/122331'}',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
        children: [
          Text(
            'Ticket',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          Text(
            'Gateway Container Line',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            'Stuffing',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 20),
          
          // QR Code
          Container(
            padding: const EdgeInsets.all(16),
            child: QrImageView(
              data: widget.ticketData['jobNumber'] ?? 'GCL-1002507096',
              version: QrVersions.auto,
              size: 150.0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            widget.ticketData['jobNumber'] ?? 'GCL-1002507096',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Please bring this QR code to our warehouse staff\nThis QR code acts as a stuffing order for our\nwarehouse',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 20),
          
          // Download Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.download,
                color: Color(0xFF374151),
                size: 20,
              ),
              label: const Text(
                'Download',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFE5E7EB)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection() {
    return Column(
      children: [
        Container(
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
                'Requested By',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.ticketData['requestedBy'] ?? 'SITI AISYAH',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  Text(
                    widget.ticketData['requestDate'] ?? '2025-07-24',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Process Stuffing',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.rocket_launch,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItemWithHeight(String label, String value, {bool isStuffingDate = false}) {
    if (isStuffingDate) {
      return Container(
        height: 60,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 12), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.3,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString, {required String type}) {
    if (dateString == null || dateString.isEmpty) {
      switch (type) {
        case 'stuffingDate':
          return '2025-07-31';
        case 'etd':
          return '2025-08-02';
        case 'closingDate':
          return '2025-08-31 00:00:00';
        default:
          return '';
      }
    }
    
    switch (type) {
      case 'stuffingDate':
      case 'etd':
        return dateString.replaceAll('T00:00:00', '').replaceAll('Z', '');
      case 'closingDate':
        return dateString.replaceAll('T', ' ').replaceAll('Z', '');
      default:
        return dateString;
    }
  }
}
