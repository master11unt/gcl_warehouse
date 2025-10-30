import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';
import '../widgets/rack/warehouse_layout_canvas.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/common/custom_drawer.dart';
import '../models/inventory_data.dart';

class InventoryDetailPage extends StatefulWidget {
  final Map<String, dynamic> inventoryData;

  const InventoryDetailPage({super.key, Map<String, dynamic>? inventoryData})
    : inventoryData = inventoryData ?? const {};

  factory InventoryDetailPage.withDummy({Key? key}) {
    return InventoryDetailPage(
      key: key,
      inventoryData: InventoryData.getDummyCargoOutDetail(),
    );
  }

  @override
  State<InventoryDetailPage> createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
  bool _isArrivalExpanded = false;
  bool _isSenderIdentityExpanded = false;
  bool _isDocumentationExpanded = false;
  bool _isLocationExpanded = false;
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

              _buildLocationSection(),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
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
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
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
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '0',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFF100),
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
                        color: Color(0xFF0F172A),
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
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Address
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Jl. Kawasan Marunda Center No.27\nBlok B, Sagara Makmur, Tarumajaya,\nBekasi Regency, West Java 17211',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0F172A),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 16,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Color(0xFF0F172A), width: 6),
                    ),
                  ),
                  child: const Text(
                    'Racking Detail',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
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

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _isLocationExpanded ? WarehouseLayoutCanvas.layoutCanvasHeight : 0,
            child: _isLocationExpanded
                ? _buildLocationLayoutContent()
                : const SizedBox(),
          ),

          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(height: 1, color: const Color(0xFFE5E7EB)),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLocationExpanded = !_isLocationExpanded;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF0F172A)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgIcon(
                        assetPath: _isLocationExpanded
                            ? 'assets/icons/chevron_up.svg'
                            : 'assets/icons/arrow_down.svg',
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(height: 1, color: const Color(0xFFE5E7EB)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationLayoutContent() {
    return const SizedBox(
      height: WarehouseLayoutCanvas.layoutCanvasHeight,
      child: WarehouseLayoutCanvas(),
    );
  }

  Widget _buildHeaderSection() {
    final data =
        widget.inventoryData.isNotEmpty
            ? widget.inventoryData
            : InventoryData.getDummyCargoOutDetail();
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
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
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
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const SvgIcon(
                  assetPath: 'assets/icons/chevron_right.svg',
                  color: Color(0xFF0F172A),
                  size: 12,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    data['bookingCode'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0F172A),
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

  Widget _buildCombinedDataSection() {
    final data =
        widget.inventoryData.isNotEmpty
            ? widget.inventoryData
            : InventoryData.getDummyCargoOutDetail();
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
                  color: const Color(0xFF0F172A),
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

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
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
                      Builder(
                        builder: (context) {
                          final bookingCode =
                              (data['bookingCodeDisplay'] ?? '') as String;
                          final parts = bookingCode.split('-');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parts.isNotEmpty ? (parts[0] + '-') : '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                parts.length > 1 ? parts[1] : '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
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
                      Builder(
                        builder: (context) {
                          final cargoOwner =
                              (data['cargoOwner'] ?? '') as String;
                          final parts = cargoOwner.split('-');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                parts.isNotEmpty ? (parts[0] + '-') : '',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                parts.length > 1 ? parts[1] : '',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
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
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(height: 1, color: const Color(0xFFE5E7EB)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildDetailItem('Date', data['date'] ?? ''),
          _buildDetailItem('Shipper', data['shipper'] ?? ''),
          _buildDetailItem(
            'Description of goods',
            data['descriptionOfGoods'] ?? '',
          ),
          _buildDetailItem('Destination', data['destination'] ?? ''),
          _buildDetailItem('Estimated Time Departure', data['etd'] ?? ''),
          _buildDetailItem('Vessel', data['vessel'] ?? ''),
          _buildDetailItem('Connecting Vessel', data['connectingVessel'] ?? ''),
          _buildDetailItem('Godownlocation', data['godownLocation'] ?? ''),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Remark',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF0F172A),
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
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(height: 2, color: const Color(0xFF0F172A)),
                      const SizedBox(height: 16),

                      // Quantity / Package row
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0F172A),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Package',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0F172A),
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
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'CARTONS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
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
                              color: Color(0xFF0F172A),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Volume',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0F172A),
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
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            '6.16 M³',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
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
                              color: Color(0xFF0F172A),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '4.2858 Cbm',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
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
                  color: Color(0xFF0F172A),
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
                border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Header Row
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
                                  color: Color(0xFFD1D5DB),
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
                          // Marking Column
                          Container(
                            width: 180,
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6B7280),
                              border: Border(
                                right: BorderSide(
                                  color: Color(0xFFD1D5DB),
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
                                          color: Color(0xFFD1D5DB),
                                          width: 1,
                                        ),
                                        bottom: BorderSide(
                                          color: Color(0xFFD1D5DB),
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
                                          color: Color(0xFFD1D5DB),
                                          width: 1,
                                        ),
                                        bottom: BorderSide(
                                          color: Color(0xFFD1D5DB),
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
                                          color: Color(0xFFD1D5DB),
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
                                          color: Color(0xFFD1D5DB),
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
                                          color: Color(0xFFD1D5DB),
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
                                          color: Color(0xFFD1D5DB),
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
                                          color: Color(0xFFD1D5DB),
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
                                          color: Color(0xFFD1D5DB),
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
                          // Meas Column
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
                        top: BorderSide(color: Color(0xFFD1D5DB), width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFD1D5DB),
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
                                color: Color(0xFF0F172A),
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
                                color: Color(0xFFD1D5DB),
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
                                color: Color(0xFF0F172A),
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFD1D5DB),
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
                                color: Color(0xFF0F172A),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFD1D5DB),
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
                                color: Color(0xFF0F172A),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFD1D5DB),
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
                                color: Color(0xFF0F172A),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFD1D5DB),
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
                                color: Color(0xFF0F172A),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFD1D5DB),
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
                                color: Color(0xFF0F172A),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFD1D5DB),
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
                                color: Color(0xFF0F172A),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 60,
                          child: const Center(
                            child: Text(
                              '0.014',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
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
                  color: Color(0xFF0F172A),
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
                          color: Color(0xFF0F172A),
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
                          color: Color(0xFF0F172A),
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
                          color: Color(0xFF0F172A),
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
                          color: Color(0xFF0F172A),
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
                          color: Color(0xFF0F172A),
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
                          color: Color(0xFF0F172A),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
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
              color: Color(0xFF0F172A),
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
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF0F172A), width: 6),
              ),
            ),
            child: const Text(
              'Options',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Options buttons
          SingleChildScrollView(
            controller: _optionsScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildOptionButton('assets/icons/option1.svg', 'Action'),
                const SizedBox(width: 21),
                _buildOptionButton('assets/icons/edit.svg', 'Edit'),
                const SizedBox(width: 21),
                _buildOptionButton('assets/icons/share.svg', 'Share'),
                const SizedBox(width: 21),
                _buildOptionButton('assets/icons/print.svg', 'Print'),
                const SizedBox(width: 21),
                _buildOptionButton(
                  'assets/icons/microphone.svg',
                  'Call Support',
                ),
                const SizedBox(width: 21),
                _buildOptionButton('assets/icons/send.svg', 'Send Tallysheet'),
              ],
            ),
          ),

          const SizedBox(height: 12),
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

  Widget _buildOptionButton(
    String assetPath,
    String label, {
    bool isDisabled = false,
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isDisabled ? const Color(0xFFE5E7EB) : const Color(0xFF374151),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: SvgIcon(
          assetPath: assetPath,
          color: isDisabled ? const Color(0xFF9CA3AF) : Colors.white,
          size: 24,
        ),
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
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF0F172A), width: 6),
              ),
            ),
            child: const Text(
              'Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
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
          _buildStatusItem('Documentation Status', 'Incomplete'),

          const SizedBox(height: 32),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF0F172A), width: 6),
              ),
            ),
            child: const Text(
              'Cargo Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
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

  Widget _buildStatusItem(String label, String value) {
    Color textColor;
    if (value.toLowerCase() == 'complete') {
      textColor = const Color(0xFF10B981);
    } else if (value.toLowerCase() == 'incomplete') {
      textColor = const Color(0xFFEF4444);
    } else {
      textColor = const Color(0xFF0F172A);
    }

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
              color: textColor,
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
                color: Color(0xFF0F172A),
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
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF0F172A), width: 6),
              ),
            ),
            child: const Text(
              'Items Exited',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 16),

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
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF0F172A), width: 6),
              ),
            ),
            child: const Text(
              'Cargo Transaction',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Column(
            children: [
              // Arrival
              _buildTimelineItem(
                isCompleted: false,
                hasConnector: false,
                title: 'Arrival',
                time: '2025-09-09 03:53',
                isExpandable: true,
                isExpanded: _isArrivalExpanded,
                onTap: () {
                  setState(() {
                    _isArrivalExpanded = !_isArrivalExpanded;
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
  }) {
    final GlobalKey cardKey = GlobalKey();

    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                const SizedBox(height: 24),
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

                if (hasConnector)
                  Container(
                    width: 2,
                    height: isExpandable && isExpanded ? 420 : 80,
                    color: const Color(0xFF6B7280),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Content card
          Expanded(
            child: GestureDetector(
              onTap: isExpandable ? onTap : null,
              child: Container(
                key: cardKey,
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
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
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
                                      color: Color(0xFF6B7280),
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
                                    title == 'Stuffed'
                                        ? '115'
                                        : title == 'Delivered'
                                        ? '4'
                                        : '32',
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
                                      color: Color(0xFF6B7280),
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
                                      color: Color(0xFF6B7280),
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
                                      color: Color(0xFF6B7280),
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

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSenderIdentityExpanded =
                                !_isSenderIdentityExpanded;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Sender Identity',
                                      style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SvgIcon(
                                      assetPath:
                                          _isSenderIdentityExpanded
                                              ? 'assets/icons/chevron_up.svg'
                                              : 'assets/icons/chevron_right.svg',
                                      color: const Color(0xFF9CA3AF),
                                      size:
                                          _isSenderIdentityExpanded
                                              ? 8
                                              : 12,
                                    ),
                                  ],
                                ),
                              ),
                              if (_isSenderIdentityExpanded) ...[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          color: Color(0xFF0F172A),
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
                                          color: Color(0xFF0F172A),
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
                                          color: Color(0xFF0F172A),
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
                        onTap: () {
                          setState(() {
                            _isDocumentationExpanded =
                                !_isDocumentationExpanded;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Documentation',
                                      style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SvgIcon(
                                      assetPath:
                                          _isDocumentationExpanded
                                              ? 'assets/icons/chevron_up.svg'
                                              : 'assets/icons/chevron_right.svg',
                                      color: const Color(0xFF9CA3AF),
                                      size:
                                          _isDocumentationExpanded
                                              ? 8
                                              : 12,
                                    ),
                                  ],
                                ),
                              ),
                              if (_isDocumentationExpanded) ...[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE5E7EB),
                                        ),
                                        child: const Center(
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
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Surat Jalan ID',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF9CA3AF),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'SJ-2025-001234',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF0F172A),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'Origin',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF9CA3AF),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Jakarta Warehouse',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF0F172A),
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
                      Text(
                        title == 'Stuffed'
                            ? 'Stuffed with job number : GCL-1002509172'
                            : title == 'Delivered'
                            ? 'Delivered with job number GCL-1002509171'
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
                        title == 'Stuffed' || title == 'Delivered'
                            ? 'NaN'
                            : 'User',
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
                      Text(
                        title == 'Delivered'
                            ? '2025-09-09 11:42:58'
                            : '2025-09-09 12:26:41',
                        style: const TextStyle(
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
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF0F172A), width: 6),
              ),
            ),
            child: const Text(
              'Cargo History',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Column(
            children: [
              _buildHistoryTimelineItem(
                isCompleted: false,
                hasConnector: false,
                title: 'Received in warehouse',
                time: '2025-09-09 13:54:10',
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                const SizedBox(height: 15),
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
                  Container(
                    width: 2,
                    height: 80,
                    color: const Color(0xFF6B7280),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
