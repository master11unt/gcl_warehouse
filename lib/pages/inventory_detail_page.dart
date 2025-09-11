import 'package:flutter/material.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/home/custom_drawer.dart';

class InventoryDetailPage extends StatefulWidget {
  final Map<String, dynamic> inventoryData;

  const InventoryDetailPage({super.key, required this.inventoryData});

  @override
  State<InventoryDetailPage> createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
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
              // Header Section
              _buildHeaderSection(),
              const SizedBox(height: 20),

              // Tallysheet Section (now includes Details and Total)
              _buildTallysheetSection(),
              const SizedBox(height: 20),

              // Marking Section
              _buildMarkingSection(),
              const SizedBox(height: 20),

              // Document Export Section
              _buildDocumentExportSection(),
              const SizedBox(height: 20),

              // Location Section
              _buildLocationSection(),
              const SizedBox(height: 20),

              // Options Section
              _buildOptionsSection(),
              const SizedBox(height: 20),

              // Status Section
              _buildStatusSection(),
              const SizedBox(height: 20),

              // Cargo Properties Section
              _buildCargoPropertiesSection(),
              const SizedBox(height: 20),

              // Items Received Section
              _buildItemsReceivedSection(),
              const SizedBox(height: 20),

              // Cargo Transaction Section
              _buildCargoTransactionSection(),
              const SizedBox(height: 20),

              // Cargo History Section
              _buildCargoHistorySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
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
      child: Row(
        children: [
          // Gray vertical bar
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF9CA3AF),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          // Content in single line
          Expanded(
            child: Row(
              children: [
                const Text(
                  'Inventory',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF1F2937),
                  size: 20,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    widget.inventoryData['bookingCode'] ?? '20250822034402',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.bold,
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

  Widget _buildTallysheetSection() {
    return Container(
      padding: const EdgeInsets.all(28),
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
          // Tallysheet header
          Row(
            children: [
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
              // const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF374151),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Tallysheet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              // const SizedBox(width: 16),
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Tallysheet content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF374151),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking Code',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'GWT-\n20250904104757',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Cargo Owner',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'GCL-\nJAKARTA',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Details section
          Row(
            children: [
              const Text(
                'Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildDetailItem('Date', '2025-09-08T19:19'),
          _buildDetailItem('Shipper', 'ZEBRA ASABA INDUSTRIES, PT'),
          _buildDetailItem(
            'Description of goods',
            '4 CARTONS OF: 2,152 PIECES OF "ZEBRA" BRAND BALLPOINT PEN 1,864 PIECES OF "ZEBRA" BRAND REFILL FOB JAKARTA',
          ),
          _buildDetailItem('Destination', 'HONG KONG'),
          _buildDetailItem('Estimated Time Departure', '2025-09-12'),
          _buildDetailItem('Vessel', 'KMTC SURABAYA V.2507N'),
          _buildDetailItem('Connecting Vessel', ''),
          _buildDetailItem('Godownlocation', 'GCLMarunda'),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Remark',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(height: 2, color: const Color(0xFF374151)),
                      const SizedBox(height: 16),

                      // Quantity / Package row
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Package',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '22',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          Text(
                            'CARTONS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Weight / Volume row
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Weight',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Volume',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1236.8 KGs',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          Text(
                            '6.16 M³',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Warehouse Meas section - vertical layout
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Warehouse Meas',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '4.2858 Cbm',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    if (label.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkingSection() {
    return Container(
      padding: const EdgeInsets.all(32),
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
          Row(
            children: [
              const Text(
                'Marking',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Tally Detail Table
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Table Header - Tally Detail
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF6B7280),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Tally Detail',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                // Column Headers
                Container(
                  child: Row(
                    children: [
                      // Quantity Column Header
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          decoration: const BoxDecoration(
                            color: Color(0xFF6B7280),
                            border: Border(
                              right: BorderSide(color: Color(0xFF9CA3AF), width: 1),
                            ),
                          ),
                          child: const Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Package Type Column Header
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          decoration: const BoxDecoration(
                            color: Color(0xFF6B7280),
                            border: Border(
                              right: BorderSide(color: Color(0xFF9CA3AF), width: 1),
                            ),
                          ),
                          child: const Text(
                            'Package Type',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Weight Column Header
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          decoration: const BoxDecoration(
                            color: Color(0xFF6B7280),
                          ),
                          child: const Text(
                            'Weight',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Data Row
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Quantity Data
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                            ),
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Package Type Data (Empty)
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                            ),
                          ),
                          child: const Text(
                            '',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Weight Data
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                          child: const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentExportSection() {
    return Container(
      padding: const EdgeInsets.all(32),
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
          Row(
            children: [
              const Text(
                'Document Export',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // PKBE Aju Section
          const Text(
            'PKBE Aju',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'Number',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      child: const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1F2937),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      child: const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1F2937),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // PKBE Section
          const Text(
            'PKBE',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'Number',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      child: const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1F2937),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      child: const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1F2937),
                        ),
                        textAlign: TextAlign.center,
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

  Widget _buildLocationSection() {
    return Container(
      padding: const EdgeInsets.all(32),
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
          // Header
          Row(
            children: [
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF374151),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Rack status with divider
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF374151),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // In Rack
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '1',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'In Rack',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Divider
                Container(
                  height: 60,
                  width: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
                // Not In Rack
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '0',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF59E0B), // Yellow color for 0
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Not In Rack',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Warehouse and Telp info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Warehouse',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Marunda',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Telp',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '(021) 29088309',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Address
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Jl. Kawasan Marunda Center No.27\nBlok B, Sagara Makmur, Tarumajaya,\nBekasi Regency, West Java 17211',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 4,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Color(0xFF374151), width: 6),
                    ),
                  ),
                  child: const Text(
                    'Racking Detail',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last Forklift',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 45,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: const Color(0xFFE5E7EB)),
                            //   borderRadius: BorderRadius.circular(6),
                            //   color: Colors.white,
                            // ),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Racking Notes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 45,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Bottom arrow
          Row(
            children: [
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
              const SizedBox(width: 16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(32),
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF374151), width: 6),
              ),
            ),
            child: const Text(
              'Options',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Options buttons
          Wrap(
            spacing: 21,
            runSpacing: 20,
            children: [
              _buildOptionButton(Icons.ads_click, 'Action'),
              _buildOptionButton(Icons.edit_square, 'Edit'),
              _buildOptionButton(Icons.share_outlined, 'Share'),
              _buildOptionButton(Icons.print_outlined, 'Print'),
              _buildOptionButton(Icons.headset_mic_rounded, 'Call Support'),
              _buildOptionButton(Icons.send, 'Send Tallysheet'),
              // _buildOptionButton(Icons.inventory, 'Inventory'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(IconData icon, String label) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(32),
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF374151), width: 6),
              ),
            ),
            child: const Text(
              'Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 16),

          _buildStatusItem('Cargo Status', 'Received In\nWarehouse'),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE5E7EB), thickness: 1),
          const SizedBox(height: 5),
          _buildStatusItem('Cargo Condition', 'All Good'),
          const SizedBox(height: 5),
          const Divider(color: Color(0xFFE5E7EB), thickness: 1),
          const SizedBox(height: 16),
          _buildStatusItem(
            'Documentation Status',
            'Incomplete',
            isIncomplete: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
    String label,
    String value, {
    bool isIncomplete = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF9CA3AF),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color:
                  isIncomplete
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF1F2937),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCargoPropertiesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(32),
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF374151), width: 6),
              ),
            ),
            child: const Text(
              'Cargo Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 16),

          _buildPropertyItem('In Charge', 'User'),
          const SizedBox(height: 16),
          _buildPropertyItem('Created By', 'User', '2025-09-09 07:43:37'),
          const SizedBox(height: 16),
          _buildPropertyItem('Last Updated by', 'User', '2025-09-09 07:43:37'),
        ],
      ),
    );
  }

  Widget _buildPropertyItem(String label, String value, [String? timestamp]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF9CA3AF),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              value.isEmpty ? '-' : value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (timestamp != null) ...[
              const SizedBox(width: 100),
              Text(
                timestamp,
                style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildItemsReceivedSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(32),
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF374151), width: 6),
              ),
            ),
            child: const Text(
              'Items Received',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Circular progress indicator
          Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF10B981),
                      ),
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '100 %',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Column(
              children: [
                Text(
                  'Status Quantity',
                  style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                ),
                Text(
                  'Match',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCargoTransactionSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(32),
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF374151), width: 6),
              ),
            ),
            child: const Text(
              'Cargo Transaction',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Timeline indicator
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF9CA3AF), width: 3),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              // Content card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Arrival',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2025-09-09 07:43',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCargoHistorySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(32),
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF374151), width: 6),
              ),
            ),
            child: const Text(
              'Cargo History',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Timeline indicator
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF9CA3AF), width: 3),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              // Content card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(8),
                  //   border: Border.all(color: const Color(0xFFE5E7EB)),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.black.withOpacity(0.1),
                  //       spreadRadius: 1,
                  //       blurRadius: 6,
                  //     ),
                  //   ],
                  // ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Received In Warehouse',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2025-09-09 19:16:14',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
