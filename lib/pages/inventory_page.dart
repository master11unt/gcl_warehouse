import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';
import 'package:gcl_warehouse/pages/inventory_detail_cargo_out_page.dart';
import '../widgets/common/custom_drawer.dart';
import 'input_cargo_in_page.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/ticket/ticket_table.dart';
import '../models/inventory_data.dart';
import '../dialogs/scan_dialog.dart';
import 'inventory_detail_page.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage>
    with TickerProviderStateMixin {
  void _showScanDialog() {
    showDialog(context: context, builder: (context) => const ScanDialog());
  }

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  int _currentPage = 1;
  int _currentPageStock = 1;
  int _currentPageCargoOut = 1;

  bool _isFilterExpandedCargoIn = false;
  bool _isFilterExpandedStock = false;
  bool _isFilterExpandedCargoOut = false;

  String _selectedCategoryCargoIn = 'None';
  DateTime? _selectedDateCargoIn;

  String _selectedCategoryStock = 'None';
  DateTime? _selectedDateStock;

  String _selectedCategoryCargoOut = 'None';
  DateTime? _selectedDateCargoOut;

  // Filter options
  final List<String> _categoryOptionsCargoIn = [
    'None',
    'Cargo In',
    'Demaged',
    'Short',
    'Over',
    'Coload',
    'Cenceled',
    'In Delivery',
    'Stuffing',
    'BC 3.0',
    'BC 3.1',
    'IDR',
    'USD',
  ];

  final List<String> _categoryOptionsStock = [
    'None',
    'Cargo In',
    'Demaged',
    'Short',
    'Over',
    'Coload',
    'Cenceled',
    'In Delivery',
    'Stuffing',
    'BC 3.0',
    'BC 3.1',
    'IDR',
    'USD',
  ];

  final List<String> _categoryOptionsCargoOut = [
    'None',
    'Cargo In',
    'Demaged',
    'Short',
    'Over',
    'Coload',
    'Cenceled',
    'In Delivery',
    'Stuffing',
    'BC 3.0',
    'BC 3.1',
    'IDR',
    'USD',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CommonAppBar(),
      drawer: CustomDrawer(currentPage: "inventory"),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _showScanDialog,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const SvgIcon(
                          assetPath: 'assets/icons/qr.svg',
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Vertical Divider
                    Container(
                      width: 2,
                      height: 50,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildTabItem(
                              Icons.description_outlined,
                              "Cargo In",
                              0,
                            ),
                            const SizedBox(width: 12),
                            _buildTabItem(
                              Icons.home_work_outlined,
                              "Stock Inventory",
                              1,
                            ),
                            const SizedBox(width: 12),
                            _buildTabItem(
                              Icons.local_shipping_outlined,
                              "Cargo Out",
                              2,
                            ),
                            const SizedBox(width: 12),
                            _buildAddTab(3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCargoInTab(),
                  _buildStockInventoryTab(),
                  _buildCargoOutTab(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCargoInTab() {
    final totalItems = InventoryData.cargoInTableData.length;
    final totalPages = InventoryData.totalPages;
    final page = _currentPage.clamp(1, totalPages);

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
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
              Row(
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
                  const Text(
                    "List Cargo In",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _toggleFilterExpanded();
                      });
                    },
                    child: const SvgIcon(
                      assetPath: 'assets/icons/filter_outline.svg',
                      color: Color(0xFF6B7280),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: SvgIcon(
                              assetPath: 'assets/icons/search.svg',
                              color: Color(0xFF6B7280),
                              size: 18,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged:
                            (value) => setState(() => searchQuery = value),
                      ),
                    ),
                  ),
                ],
              ),

              if (_getFilterExpanded())
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Time Filter',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFE5E7EB)),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDatePicker(
                                      initialDate: _getSelectedDate(),
                                      onDateSelected: (DateTime selectedDate) {
                                        setState(() {
                                          _setSelectedDate(selectedDate);
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        () {
                                          final DateTime? currentDate =
                                              _getSelectedDate();
                                          return currentDate != null
                                              ? '${currentDate.day}/${currentDate.month}/${currentDate.year}'
                                              : 'Select Date';
                                        }(),
                                        style: const TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SvgIcon(
                                      assetPath: 'assets/icons/calendar.svg',
                                      color: Color(0xFF6B7280),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Category Filter
                        const Text(
                          'Category Filter',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          height: 50,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  _getCategoryOptions()
                                      .map(
                                        (category) => Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          child: _buildFilterChip(
                                            category,
                                            _getSelectedCategory() == category,
                                            () => setState(
                                              () => _setSelectedCategory(
                                                category,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Action',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  print('Generate Report tapped');
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Color(0xFFE5E7EB),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SvgIcon(
                                        assetPath:
                                            'assets/icons/table_chart.svg',
                                        color: Color(0xFF374151),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          'Generate Report',
                                          style: const TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 6),

                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  print('Send tapped');
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Color(0xFFE5E7EB),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SvgIcon(
                                        assetPath: 'assets/icons/send.svg',
                                        color: Color(0xFF374151),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          'Send',
                                          style: const TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              TicketTable(
                columns: const [
                  'Booking Code',
                  'Date In',
                  'Shipper',
                  'Destination',
                  'Quantity',
                  'Marking',
                  'Description of Goods',
                  'Warehouse Meas',
                  'Weight (KGs)',
                  'PEB Number',
                  'PEB Date',
                  'NPE Number',
                  'NPE Date',
                  'Value',
                  'Currency',
                  'Status',
                ],
                columnWidths: const [
                  120, // Booking Code
                  130, // Date In
                  200, // Shipper
                  100, // Destination
                  80, // Quantity
                  80, // Marking
                  110, // Description of Goods
                  90, // Warehouse Meas
                  80, // Weight (KGs)
                  100, // PEB Number
                  80, // PEB Date
                  100, // NPE Number
                  80, // NPE Date
                  60, // Value
                  50, // Currency
                  220, // Status
                ],
                rows: InventoryData.cargoInTableData,
                emptyMessage: 'Showing Result',
                currentPage: page,
                totalPages: totalPages,
                totalItems: totalItems,
                pageSize: InventoryData.pageSize,
                onPageChange:
                    (p) =>
                        setState(() => _currentPage = p.clamp(1, totalPages)),
                onRowTap: (rowData) {
                  final rowMap = {
                    'bookingCode': rowData[0],
                    'bookingCodeDisplay': rowData[0],
                    'date': rowData[1],
                    'shipper': rowData[2],
                    'cargoOwner': 'GCL-JAKARTA',
                    'destination': rowData[3],
                    'quantity': rowData[4],
                    'package': rowData[4].split(' ').last,
                    'marking': rowData[5],
                    'descriptionOfGoods': rowData[6],
                    'warehouseMeas': rowData[7],
                    'weight': rowData[8],
                    'volume': rowData[7],
                    'pebNumber': rowData[9],
                    'pebDate': rowData[10],
                    'npeNumber': rowData[11],
                    'npeDate': rowData[12],
                    'value': rowData[13],
                    'currency': rowData[14],
                    'status': rowData[15],
                    'etd': rowData[16],
                    'vessel': rowData[17],
                    'connectingVessel': rowData[18],
                    'godownLocation': rowData[19],
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              InventoryDetailPage(inventoryData: rowMap),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStockInventoryTab() {
    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
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
              Row(
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
                  const Text(
                    "Stock Inventory",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _toggleFilterExpanded();
                      });
                    },
                    child: const SvgIcon(
                      assetPath: 'assets/icons/filter_outline.svg',
                      color: Color(0xFF6B7280),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: SvgIcon(
                              assetPath: 'assets/icons/search.svg',
                              color: Color(0xFF6B7280),
                              size: 18,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged:
                            (value) => setState(() => searchQuery = value),
                      ),
                    ),
                  ),
                ],
              ),

              if (_getFilterExpanded())
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Time Filter Section
                        const Text(
                          'Time Filter',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFE5E7EB)),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDatePicker(
                                      initialDate: _getSelectedDate(),
                                      onDateSelected: (DateTime selectedDate) {
                                        setState(() {
                                          _setSelectedDate(selectedDate);
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        () {
                                          final DateTime? currentDate =
                                              _getSelectedDate();
                                          return currentDate != null
                                              ? '${currentDate.day}/${currentDate.month}/${currentDate.year}'
                                              : 'Select Date';
                                        }(),
                                        style: const TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SvgIcon(
                                      assetPath: 'assets/icons/calendar.svg',
                                      color: Color(0xFF6B7280),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Category Filter',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          height: 50,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  _getCategoryOptions()
                                      .map(
                                        (category) => Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          child: _buildFilterChip(
                                            category,
                                            _getSelectedCategory() == category,
                                            () => setState(
                                              () => _setSelectedCategory(
                                                category,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Action',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  print('Generate Report tapped');
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Color(0xFFE5E7EB),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SvgIcon(
                                        assetPath:
                                            'assets/icons/table_chart.svg',
                                        color: Color(0xFF374151),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          'Generate Report',
                                          style: const TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 6),

                            // Send Button
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  print('Send tapped');
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Color(0xFFE5E7EB),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SvgIcon(
                                        assetPath: 'assets/icons/send.svg',
                                        color: Color(0xFF374151),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          'Send',
                                          style: const TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              TicketTable(
                columns: const [
                  'Booking Code',
                  'Date In',
                  'Shipper',
                  'Destination',
                  'Quantity',
                  'Marking',
                  'Description of Goods',
                  'Warehouse Meas',
                  'Weight (KGs)',
                  'PEB Number',
                  'PEB Date',
                  'NPE Number',
                  'NPE Date',
                  'Value',
                  'Currency',
                  'Status',
                ],
                columnWidths: const [
                  120, // Booking Code
                  130, // Date In
                  200, // Shipper
                  100, // Destination
                  80, // Quantity
                  80, // Marking
                  110, // Description of Goods
                  90, // Warehouse Meas
                  80, // Weight (KGs)
                  100, // PEB Number
                  80, // PEB Date
                  100, // NPE Number
                  80, // NPE Date
                  60, // Value
                  50, // Currency
                  220, // Status
                ],
                rows: InventoryData.stockInventoryTableData,
                emptyMessage: 'Showing Result',
                currentPage: _currentPageStock,
                totalPages:
                    (InventoryData.stockInventoryTableData.length /
                            InventoryData.pageSize)
                        .ceil(),
                totalItems: InventoryData.stockInventoryTableData.length,
                pageSize: InventoryData.pageSize,
                onPageChange: (p) => setState(() => _currentPageStock = p),
                onRowTap: (rowData) {
                  final rowMap = {
                    'bookingCode': rowData[0],
                    'bookingCodeDisplay': rowData[0],
                    'date': rowData[1],
                    'shipper': rowData[2],
                    'cargoOwner': 'GCL-JAKARTA',
                    'destination': rowData[3],
                    'quantity': rowData[4],
                    'package': rowData[4].split(' ').last,
                    'marking': rowData[5],
                    'descriptionOfGoods': rowData[6],
                    'warehouseMeas': rowData[7],
                    'weight': rowData[8],
                    'volume': rowData[7],
                    'pebNumber': rowData[9],
                    'pebDate': rowData[10],
                    'npeNumber': rowData[11],
                    'npeDate': rowData[12],
                    'value': rowData[13],
                    'currency': rowData[14],
                    'status': rowData[15],
                    'etd': rowData.length > 16 ? rowData[16] : '',
                    'vessel': rowData.length > 17 ? rowData[17] : '',
                    'connectingVessel': rowData.length > 18 ? rowData[18] : '',
                    'godownLocation': rowData.length > 19 ? rowData[19] : '',
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              InventoryDetailPage(inventoryData: rowMap),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCargoOutTab() {
    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
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
              Row(
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
                  const Text(
                    "List Cargo Out",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _toggleFilterExpanded();
                      });
                    },
                    child: const SvgIcon(
                      assetPath: 'assets/icons/filter_outline.svg',
                      color: Color(0xFF6B7280),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: SvgIcon(
                              assetPath: 'assets/icons/search.svg',
                              color: Color(0xFF6B7280),
                              size: 18,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged:
                            (value) => setState(() => searchQuery = value),
                      ),
                    ),
                  ),
                ],
              ),

              if (_getFilterExpanded())
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Time Filter',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFE5E7EB)),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDatePicker(
                                      initialDate: _getSelectedDate(),
                                      onDateSelected: (DateTime selectedDate) {
                                        setState(() {
                                          _setSelectedDate(selectedDate);
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        () {
                                          final DateTime? currentDate =
                                              _getSelectedDate();
                                          return currentDate != null
                                              ? '${currentDate.day}/${currentDate.month}/${currentDate.year}'
                                              : 'Select Date';
                                        }(),
                                        style: const TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SvgIcon(
                                      assetPath: 'assets/icons/calendar.svg',
                                      color: Color(0xFF6B7280),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Category Filter',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          height: 50,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  _getCategoryOptions()
                                      .map(
                                        (category) => Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          child: _buildFilterChip(
                                            category,
                                            _getSelectedCategory() == category,
                                            () => setState(
                                              () => _setSelectedCategory(
                                                category,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Action',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  print('Generate Report tapped');
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Color(0xFFE5E7EB),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SvgIcon(
                                        assetPath:
                                            'assets/icons/table_chart.svg',
                                        color: Color(0xFF374151),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          'Generate Report',
                                          style: const TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 6),

                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  print('Send tapped');
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Color(0xFFE5E7EB),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SvgIcon(
                                        assetPath: 'assets/icons/send.svg',
                                        color: Color(0xFF374151),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          'Send',
                                          style: const TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              TicketTable(
                columns: const [
                  'Booking Code',
                  'Date In',
                  'Shipper',
                  'Destination',
                  'Quantity',
                  'Marking',
                  'Description of Goods',
                  'Warehouse Meas',
                  'Weight (KGs)',
                  'PEB Number',
                  'PEB Date',
                  'NPE Number',
                  'NPE Date',
                  'Value',
                  'Currency',
                  'Status',
                ],
                columnWidths: const [
                  120, // Booking Code
                  130, // Date In
                  200, // Shipper
                  100, // Destination
                  80, // Quantity
                  80, // Marking
                  110, // Description of Goods
                  90, // Warehouse Meas
                  80, // Weight (KGs)
                  100, // PEB Number
                  80, // PEB Date
                  100, // NPE Number
                  80, // NPE Date
                  60, // Value
                  50, // Currency
                  220, // Status
                ],
                rows: InventoryData.cargoOutTableData,
                emptyMessage: 'Showing Result',
                currentPage: _currentPageCargoOut,
                totalPages:
                    (InventoryData.cargoOutTableData.length /
                            InventoryData.pageSize)
                        .ceil(),
                totalItems: InventoryData.cargoOutTableData.length,
                pageSize: InventoryData.pageSize,
                onPageChange: (p) => setState(() => _currentPageCargoOut = p),
                onRowTap: (rowData) {
                  final dummy = InventoryData.getDummyCargoOutDetail();
                  final rowMap = {
                    'bookingCode': rowData[0],
                    'bookingCodeDisplay': rowData[0],
                    'date': rowData[1],
                    'shipper': rowData[2],
                    'cargoOwner': 'GCL-JAKARTA',
                    'destination': rowData[3],
                    'quantity': rowData[4],
                    'package': rowData[4].split(' ').last,
                    'marking': rowData[5],
                    'descriptionOfGoods': rowData[6],
                    'warehouseMeas': rowData[7],
                    'weight': rowData[8],
                    'volume': rowData[7],
                    'pebNumber': rowData[9],
                    'pebDate': rowData[10],
                    'npeNumber': rowData[11],
                    'npeDate': rowData[12],
                    'value': rowData[13],
                    'currency': rowData[14],
                    'status': rowData[15],
                    'etd': rowData.length > 16 ? rowData[16] : '',
                    'vessel': rowData.length > 17 ? rowData[17] : '',
                    'connectingVessel': rowData.length > 18 ? rowData[18] : '',
                    'godownLocation': rowData.length > 19 ? rowData[19] : '',
                  };
                  final merged = {...dummy, ...rowMap};
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => InventoryDetailCargoOutPage(
                            inventoryData: merged,
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(IconData icon, String text, int index) {
    final bool isSelected = _tabController.index == index;

    String assetPath;
    switch (index) {
      case 0: // Cargo In
        assetPath =
            isSelected
                ? 'assets/icons/inventory.svg'
                : 'assets/icons/inventory_outline.svg';
        break;
      case 1: // Stock Inventory
        assetPath =
            isSelected
                ? 'assets/icons/stock_int.svg'
                : 'assets/icons/stock_int_outline.svg';
        break;
      case 2: // Cargo Out
        assetPath =
            isSelected
                ? 'assets/icons/cargo_out.svg'
                : 'assets/icons/cargo_out_outline.svg';
        break;
      default:
        assetPath = 'assets/icons/inventory_outline.svg';
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.animateTo(index);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(assetPath: assetPath, color: Colors.white, size: 32),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddTab(int index) {
    final bool isSelected = _tabController.index == index;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InputCargoInPage()),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.white.withOpacity(0.1)
                        : Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: isSelected ? 3 : 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: SvgIcon(
                  assetPath:
                      isSelected
                          ? 'assets/icons/add.svg'
                          : 'assets/icons/add.svg',
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _getFilterExpanded() {
    switch (_tabController.index) {
      case 0:
        return _isFilterExpandedCargoIn;
      case 1:
        return _isFilterExpandedStock;
      case 2:
        return _isFilterExpandedCargoOut;
      default:
        return false;
    }
  }

  void _toggleFilterExpanded() {
    switch (_tabController.index) {
      case 0:
        _isFilterExpandedCargoIn = !_isFilterExpandedCargoIn;
        break;
      case 1:
        _isFilterExpandedStock = !_isFilterExpandedStock;
        break;
      case 2:
        _isFilterExpandedCargoOut = !_isFilterExpandedCargoOut;
        break;
    }
  }

  DateTime? _getSelectedDate() {
    switch (_tabController.index) {
      case 0:
        return _selectedDateCargoIn;
      case 1:
        return _selectedDateStock;
      case 2:
        return _selectedDateCargoOut;
      default:
        return null;
    }
  }

  void _setSelectedDate(DateTime date) {
    switch (_tabController.index) {
      case 0:
        _selectedDateCargoIn = date;
        break;
      case 1:
        _selectedDateStock = date;
        break;
      case 2:
        _selectedDateCargoOut = date;
        break;
    }
  }

  String _getSelectedCategory() {
    switch (_tabController.index) {
      case 0:
        return _selectedCategoryCargoIn;
      case 1:
        return _selectedCategoryStock;
      case 2:
        return _selectedCategoryCargoOut;
      default:
        return 'None';
    }
  }

  void _setSelectedCategory(String category) {
    switch (_tabController.index) {
      case 0:
        _selectedCategoryCargoIn = category;
        break;
      case 1:
        _selectedCategoryStock = category;
        break;
      case 2:
        _selectedCategoryCargoOut = category;
        break;
    }
  }

  List<String> _getCategoryOptions() {
    switch (_tabController.index) {
      case 0:
        return _categoryOptionsCargoIn;
      case 1:
        return _categoryOptionsStock;
      case 2:
        return _categoryOptionsCargoOut;
      default:
        return _categoryOptionsCargoIn;
    }
  }

  Widget _buildFilterChip(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF374151),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({
    Key? key,
    this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialDate ?? DateTime.now();
    _selectedDate = widget.initialDate;
  }

  void _onQuickSelect(String option) {
    DateTime selectedDate;
    switch (option) {
      case 'Today':
        selectedDate = DateTime.now();
        break;
      case 'Yesterday':
        selectedDate = DateTime.now().subtract(const Duration(days: 1));
        break;
      case 'Last 7 days':
        selectedDate = DateTime.now().subtract(const Duration(days: 7));
        break;
      case 'Last 30 days':
        selectedDate = DateTime.now().subtract(const Duration(days: 30));
        break;
      case 'This month':
        selectedDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
        break;
      case 'Last month':
        final now = DateTime.now();
        selectedDate = DateTime(now.year, now.month - 1, 1);
        break;
      default:
        selectedDate = DateTime.now();
    }

    setState(() {
      _selectedDate = selectedDate;
      _currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    });
    widget.onDateSelected(selectedDate);
    Navigator.pop(context);
  }

  void _onDateTap(int day) {
    final selectedDate = DateTime(_currentMonth.year, _currentMonth.month, day);
    setState(() {
      _selectedDate = selectedDate;
    });
    widget.onDateSelected(selectedDate);
    Navigator.pop(context);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  List<String> _getMonthName() {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months;
  }

  @override
  Widget build(BuildContext context) {
    final monthNames = _getMonthName();
    final currentMonthName = monthNames[_currentMonth.month - 1];

    return Dialog(
      backgroundColor: const Color(0xFF2D3748),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: [
                _buildQuickOption('Today'),
                _buildQuickOption('Yesterday'),
                _buildQuickOption('Last 7 days'),
                _buildQuickOption('Last 30 days'),
                _buildQuickOption('This month'),
                _buildQuickOption('Last month'),
              ],
            ),

            const SizedBox(height: 20),

            // Month/Year navigation
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF4A5568)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _previousMonth,
                    child: const SvgIcon(
                      assetPath: 'assets/icons/chevron_left.svg',
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Text(
                    '$currentMonthName ${_currentMonth.year}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: _nextMonth,
                    child: const SvgIcon(
                      assetPath: 'assets/icons/chevron_right.svg',
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Day headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Sun',
                  style: TextStyle(color: Color(0xFF718096), fontSize: 12),
                ),
                Text(
                  'Mon',
                  style: TextStyle(color: Color(0xFF718096), fontSize: 12),
                ),
                Text(
                  'Tue',
                  style: TextStyle(color: Color(0xFF718096), fontSize: 12),
                ),
                Text(
                  'Wed',
                  style: TextStyle(color: Color(0xFF718096), fontSize: 12),
                ),
                Text(
                  'Thu',
                  style: TextStyle(color: Color(0xFF718096), fontSize: 12),
                ),
                Text(
                  'Fri',
                  style: TextStyle(color: Color(0xFF718096), fontSize: 12),
                ),
                Text(
                  'Sat',
                  style: TextStyle(color: Color(0xFF718096), fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Calendar grid
            _buildCalendarGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickOption(String text) {
    return GestureDetector(
      onTap: () => _onQuickSelect(text),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF63B3ED),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final startOfWeek = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );

    List<Widget> dayWidgets = [];

    for (int i = 0; i < 42; i++) {
      final date = startOfWeek.add(Duration(days: i));
      final isCurrentMonth = date.month == _currentMonth.month;
      final isSelected =
          _selectedDate != null &&
          date.year == _selectedDate!.year &&
          date.month == _selectedDate!.month &&
          date.day == _selectedDate!.day;
      final isToday =
          date.year == DateTime.now().year &&
          date.month == DateTime.now().month &&
          date.day == DateTime.now().day;

      dayWidgets.add(
        GestureDetector(
          onTap: isCurrentMonth ? () => _onDateTap(date.day) : null,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF63B3ED) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color:
                      isCurrentMonth
                          ? (isSelected
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : Colors.white)
                          : const Color(0xFF4A5568),
                  fontSize: 14,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      children: dayWidgets,
    );
  }
}
