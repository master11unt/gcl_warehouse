import 'package:flutter/material.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/home/custom_drawer.dart';

class InventoryDetailCargoOutPage extends StatefulWidget {
  final Map<String, dynamic> inventoryData;

  const InventoryDetailCargoOutPage({super.key, required this.inventoryData});

  @override
  State<InventoryDetailCargoOutPage> createState() =>
      _InventoryDetailCargoOutPageState();
}

class _InventoryDetailCargoOutPageState
    extends State<InventoryDetailCargoOutPage> {
  bool _isArrivalExpanded = false;
  bool _isStuffedExpanded = false;
  bool _isDeliveredExpanded = false;
  
  bool _isArrivalSenderIdentityExpanded = false;
  bool _isArrivalDocumentationExpanded = false;
  bool _isStuffedSenderIdentityExpanded = false;
  bool _isStuffedDocumentationExpanded = false;
  bool _isDeliveredSenderIdentityExpanded = false;
  bool _isDeliveredDocumentationExpanded = false;
  
  late ScrollController _optionsScrollController;
  double _scrollIndicatorPosition = 0.0;
  
  @override
  void initState() {
    super.initState();
    _optionsScrollController = ScrollController();
    _optionsScrollController.addListener(_updateScrollIndicator);
  }
  
  @override
  void dispose() {
    _optionsScrollController.removeListener(_updateScrollIndicator);
    _optionsScrollController.dispose();
    super.dispose();
  }
  
  void _updateScrollIndicator() {
    if (_optionsScrollController.hasClients) {
      final maxScroll = _optionsScrollController.position.maxScrollExtent;
      final currentScroll = _optionsScrollController.offset;
      if (maxScroll > 0) {
        setState(() {
          _scrollIndicatorPosition = (currentScroll / maxScroll) * 40;
        });
      }
    }
  }

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
              _buildHeaderSection(),
              const SizedBox(height: 20),

              // Combined Tallysheet, Marking, and Document Export Section
              _buildCombinedDataSection(),
              const SizedBox(height: 20),

              _buildCargoOutInfoSection(),
              const SizedBox(height: 20),

              _buildOptionsSection(),
              const SizedBox(height: 20),

              // Combined Status and Cargo Properties Section
              _buildCombinedStatusCargoSection(),
              const SizedBox(height: 20),

              _buildItemsReceivedSection(),
              const SizedBox(height: 20),

              _buildCargoTransactionSection(),
              const SizedBox(height: 20),

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
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF9CA3AF),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Inventory',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF374151),
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

  Widget _buildCargoOutInfoSection() {
    return Container(
      width: double.infinity,
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 24),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 20,
                  left: 50,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 60,
                  child: Container(
                    width: 2,
                    height: 30,
                    color: const Color(0xFF6B7280).withOpacity(0.3),
                  ),
                ),

                Center(
                  child: Container(
                    width: 140,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF9CA3AF),
                      size: 50,
                    ),
                  ),
                ),

                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.help_outline, color: Colors.white, size: 20),
                        SizedBox(height: 4),
                        Text(
                          '?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  child: Container(
                    width: 40,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1F2937),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 18,
                  child: Container(
                    width: 2,
                    height: 40,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),

          const Text(
            'Sorry, I think we already exiting this cargo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF374151),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Please check again or if there something suspicious\ncontact support',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF374151),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF9CA3AF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'RULES : GTW/SOP/JKT/122331',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCombinedDataSection() {
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
          // TALLYSHEET SECTION
          Row(
            children: [
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
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
              color: const Color(0xFF1F2937),
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
                  color: Color(0xFF374151),
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
                    color: Color(0xFF374151),
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
                          color: Color(0xFF374151),
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
                              color: Color(0xFF374151),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Package',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF374151),
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
                              color: Color(0xFF374151),
                            ),
                          ),
                          Text(
                            'CARTONS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374151),
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
                              color: Color(0xFF374151),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Volume',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF374151),
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
                              color: Color(0xFF374151),
                            ),
                          ),
                          Text(
                            '6.16 M³',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Warehouse Meas section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Warehouse Meas',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF374151),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '4.2858 Cbm',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374151),
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

          const SizedBox(height: 32),

          // MARKING SECTION
          Row(
            children: [
              const Text(
                'Marking',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 70,
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6B7280),
                              border: Border(
                                right: BorderSide(
                                  color: Color(0xFFE5E7EB),
                                  width: 1,
                                ),
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: 180,
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6B7280),
                              border: Border(
                                right: BorderSide(
                                  color: Color(0xFFE5E7EB),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Marking',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 210,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6B7280),
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                        bottom: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Tally Detail',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 210,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6B7280),
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                        bottom: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Dimension (cms)',
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
                              Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6B7280),
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6B7280),
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Package\nType',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          height: 1.1,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6B7280),
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Weight',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6B7280),
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'W',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6B7280),
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'L',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6B7280),
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'H',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 100,
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6B7280),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Meas\n(Cb.M)',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Data Row
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border(
                        top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        // No Data
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // Marking Data
                        Container(
                          width: 180,
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'ZBP HONG KONG\nC/NO.1-ZA-HK-7-25',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // Quantity Data
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // Package Type Data
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // Weight Data
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '0',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // W Data
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '22',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // L Data
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '30',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // H Data
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '22',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // Meas Data
                        Container(
                          width: 100,
                          height: 60,
                          child: const Center(
                            child: Text(
                              '0.014',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
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
          ),

          const SizedBox(height: 32),

          // DOCUMENT EXPORT SECTION
          Row(
            children: [
              const Text(
                'Document Export',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151),
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
              color: Color(0xFF374151),
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
                          color: Color(0xFF374151),
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
                          color: Color(0xFF374151),
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
                          color: Color(0xFF374151),
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
                          color: Color(0xFF374151),
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
              color: Color(0xFF374151),
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
                          color: Color(0xFF374151),
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
                          color: Color(0xFF374151),
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
                          color: Color(0xFF374151),
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
                          color: Color(0xFF374151),
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
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.w600, 
            ),
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
                left: BorderSide(color: Color(0xFF1F2937), width: 6),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _optionsScrollController,
            child: Row(
              children: [
                _buildOptionButton(Icons.ads_click, 'Action', isEnabled: false),
                const SizedBox(width: 16),
                _buildOptionButton(Icons.edit_square, 'Edit', isEnabled: false),
                const SizedBox(width: 16),
                _buildOptionButton(Icons.share_outlined, 'Share'),
                const SizedBox(width: 16),
                _buildOptionButton(Icons.print_outlined, 'Print'),
                const SizedBox(width: 16),
                _buildOptionButton(Icons.headset_mic_rounded, 'Call Support'),
                const SizedBox(width: 16),
                _buildOptionButton(Icons.send, 'Send Tallysheet'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Scroll indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 100),
                      left: _scrollIndicatorPosition,
                      child: Container(
                        width: 20,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(2),
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
    );
  }

  Widget _buildOptionButton(IconData icon, String label, {bool isEnabled = true}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isEnabled ? const Color(0xFF1F2937) : const Color(0xFF9CA3AF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, 
            color: isEnabled ? Colors.white : const Color(0xFFD1D5DB), 
            size: 24
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildCombinedStatusCargoSection() {
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
          // Status Section
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
                color: Color(0xFF374151),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildStatusItem('Cargo Status', 'Exited From\nWarehouse'),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE5E7EB), thickness: 1),
          const SizedBox(height: 5),
          _buildStatusItem('Cargo Condition', 'All Good'),
          const SizedBox(height: 5),
          const Divider(color: Color(0xFFE5E7EB), thickness: 1),
          const SizedBox(height: 16),
          _buildStatusItem(
            'Documentation Status',
            'Complete', // Status: "Complete" = Green, "Incomplete" = Red
          ),
          // Example with Incomplete status:
          // _buildStatusItem(
          //   'Documentation Status',
          //   'Incomplete',
          // ),

          const SizedBox(height: 32),

          // Cargo Properties Section
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
                color: Color(0xFF374151),
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

  Widget _buildStatusItem(
    String label,
    String value,
  ) {
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
              color: value.toLowerCase() == 'complete'
                  ? const Color(0xFF10B981) // Green for Complete
                  : value.toLowerCase() == 'incomplete'
                      ? const Color(0xFFEF4444) // Red for Incomplete
                      : const Color(0xFF374151), // Default gray
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
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
                color: Color(0xFF374151),
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
              'Items Exited',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF374151),
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
                color: Color(0xFF374151),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Timeline container
          Column(
            children: [
              // Arrival
              _buildTimelineItem(
                isCompleted: true,
                hasConnector: true,
                title: 'Arrival',
                time: '2025-09-09 03:53',
                isExpandable: true,
                isExpanded: _isArrivalExpanded,
                onTap: () {
                  setState(() {
                    _isArrivalExpanded = !_isArrivalExpanded;
                  });
                },
                isSenderIdentityExpanded: _isArrivalSenderIdentityExpanded,
                isDocumentationExpanded: _isArrivalDocumentationExpanded,
                onSenderIdentityTap: () {
                  setState(() {
                    _isArrivalSenderIdentityExpanded = !_isArrivalSenderIdentityExpanded;
                  });
                },
                onDocumentationTap: () {
                  setState(() {
                    _isArrivalDocumentationExpanded = !_isArrivalDocumentationExpanded;
                  });
                },
              ),
              SizedBox(
                height: (_isArrivalExpanded || _isStuffedExpanded) ? 16 : 4,
              ),

              // Stuffed
              _buildTimelineItem(
                isCompleted: true,
                hasConnector: true,
                title: 'Stuffed',
                time: '2025-09-09 06:56',
                isExpandable: true,
                isExpanded: _isStuffedExpanded,
                onTap: () {
                  setState(() {
                    _isStuffedExpanded = !_isStuffedExpanded;
                  });
                },
                isSenderIdentityExpanded: _isStuffedSenderIdentityExpanded,
                isDocumentationExpanded: _isStuffedDocumentationExpanded,
                onSenderIdentityTap: () {
                  setState(() {
                    _isStuffedSenderIdentityExpanded = !_isStuffedSenderIdentityExpanded;
                  });
                },
                onDocumentationTap: () {
                  setState(() {
                    _isStuffedDocumentationExpanded = !_isStuffedDocumentationExpanded;
                  });
                },
              ),
              SizedBox(
                height: (_isStuffedExpanded || _isDeliveredExpanded) ? 16 : 4,
              ),

              // Delivered
              _buildTimelineItem(
                isCompleted: false,
                hasConnector: false,
                title: 'Delivered',
                time: '2025-09-09 11:42',
                isExpandable: true,
                isExpanded: _isDeliveredExpanded,
                onTap: () {
                  setState(() {
                    _isDeliveredExpanded = !_isDeliveredExpanded;
                  });
                },
                isSenderIdentityExpanded: _isDeliveredSenderIdentityExpanded,
                isDocumentationExpanded: _isDeliveredDocumentationExpanded,
                onSenderIdentityTap: () {
                  setState(() {
                    _isDeliveredSenderIdentityExpanded = !_isDeliveredSenderIdentityExpanded;
                  });
                },
                onDocumentationTap: () {
                  setState(() {
                    _isDeliveredDocumentationExpanded = !_isDeliveredDocumentationExpanded;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required bool isCompleted,
    required bool hasConnector,
    required String title,
    required String time,
    bool isExpandable = false,
    bool isExpanded = false,
    VoidCallback? onTap,
    // Parameters for dropdown states
    bool isSenderIdentityExpanded = false,
    bool isDocumentationExpanded = false,
    VoidCallback? onSenderIdentityTap,
    VoidCallback? onDocumentationTap,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column (circle + connector)
          Column(
            children: [
              // Timeline indicator
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? const Color(0xFF6B7280) : Colors.white,
                  border: Border.all(
                    color: const Color(0xFF6B7280),
                    width: isCompleted ? 0 : 3,
                  ),
                ),
              ),

              // Timeline connector line
              if (hasConnector)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: const Color(0xFF6B7280),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content card
          Expanded(
            child: GestureDetector(
              onTap: isExpandable ? onTap : null,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF374151),
                      ),
                    ),

                    if (isExpandable && isExpanded) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Condition',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),

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
                                    'Good',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF374151),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Text(
                                    title == 'Stuffed' ? '115' : '32',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6B7280),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
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
                                    'Damaged',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF374151),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6B7280),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
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
                                    'Short',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF374151),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6B7280),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
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
                                    'Over',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF374151),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6B7280),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Text(
                        'Package',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Expandable sections
                      GestureDetector(
                        onTap: onSenderIdentityTap,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Sender Identity',
                                      style: TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      isSenderIdentityExpanded ? Icons.expand_less : Icons.chevron_right, 
                                      color: const Color(0xFF9CA3AF)
                                    ),
                                  ],
                                ),
                              ),
                              if (isSenderIdentityExpanded) ...[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Truck Number',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF9CA3AF),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'B 1234 ABC',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF374151),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'Driver Name',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF9CA3AF),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Ahmad Susanto',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF374151),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'Driver Contact',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF9CA3AF),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '+62 812-3456-7890',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF374151),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: onDocumentationTap,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Documentation',
                                      style: TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      isDocumentationExpanded ? Icons.expand_less : Icons.chevron_right,
                                      color: const Color(0xFF9CA3AF)
                                    ),
                                  ],
                                ),
                              ),
                              if (isDocumentationExpanded) ...[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Received status badge - full width gray bar
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE5E7EB),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Received',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF6B7280),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Surat Jalan ID',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF9CA3AF),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'SJ-2025-001234',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF374151),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'Origin',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF9CA3AF),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Jakarta Warehouse',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF374151),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Notes content - different for Stuffed vs Arrival
                      Text(
                        title == 'Stuffed'
                            ? 'Stuffed with job number : GCL-1002509172'
                            : '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'In Charge',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9CA3AF),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        title == 'Stuffed' ? 'NaN' : 'User',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Last Updated At',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9CA3AF),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const Text(
                        '2025-09-09 12:26:41',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Photo Cargo',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9CA3AF),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
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
                color: Color(0xFF374151),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Timeline container
          Column(
            children: [
              // Received in warehouse
              _buildHistoryTimelineItem(
                isCompleted: true,
                hasConnector: true,
                title: 'Received in warehouse',
                time: '2025-09-09 13:54:10',
              ),

              // Stuffing
              _buildHistoryTimelineItem(
                isCompleted: true,
                hasConnector: true,
                title: 'Stuffing',
                time: '2025-09-09 13:56:35',
              ),

              // Deliver to destination
              _buildHistoryTimelineItem(
                isCompleted: true,
                hasConnector: false,
                title: 'Deliver to destination',
                time: '2025-09-09 18:42:58',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTimelineItem({
    required bool isCompleted,
    required bool hasConnector,
    required String title,
    required String time,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column (circle + connector)
          SizedBox(
            width: 20,
            child: Column(
              children: [
                // Timeline indicator
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? const Color(0xFF6B7280) : Colors.white,
                    border: Border.all(
                      color: const Color(0xFF6B7280),
                      width: isCompleted ? 0 : 3,
                    ),
                  ),
                ),

                // Timeline connector line
                if (hasConnector)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
