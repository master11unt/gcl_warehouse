import 'package:flutter/material.dart';
import 'package:gcl_warehouse/pages/inventory_detail_cargo_out_page.dart';
import '../widgets/home/custom_drawer.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/ticket/ticket_table.dart';
import '../models/inventory_data.dart';
import 'warehouse_layout_page.dart';
import 'inventory_detail_page.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  int _currentPage = 1;

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
                color: const Color(0xFF1F2937),
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
                    // QR Code Icon
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.qr_code_2,
                        color: Colors.white,
                        size: 40, 
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
                    
                    // Scrollable Tabs
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildTabItem(Icons.description_outlined, "Cargo In", 0),
                            const SizedBox(width: 12),
                            _buildTabItem(Icons.home_work_outlined, "Stock Inventory", 1),
                            const SizedBox(width: 12),
                            _buildTabItem(Icons.local_shipping_outlined, "Cargo Out", 2),
                            const SizedBox(width: 12),
                            _buildCustomLayoutTab(3),
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
                  _buildWarehouseLayoutTab(),
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
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "List Cargo In",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(Icons.tune, color: Color(0xFF6B7280)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF6B7280),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF374151),
                              width: 2,
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
                              color: Color(0xFF374151),
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) => setState(() => searchQuery = value),
                      ),
                    ),
                  ),
                ],
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
                  200, // Shipper - tetap panjang karena data panjang
                  100, // Destination
                  80,  // Quantity
                  80,  // Marking
                  110, // Description of Goods
                  90,  // Warehouse Meas
                  80,  // Weight (KGs)
                  100, // PEB Number
                  80,  // PEB Date
                  100, // NPE Number
                  80,  // NPE Date
                  60,  // Value
                  50,  // Currency
                  220, // Status - tetap panjang karena data panjang
                ],
                rows: InventoryData.cargoInTableData,
                emptyMessage: 'Showing Result',
                currentPage: page,
                totalPages: totalPages,
                totalItems: totalItems,
                pageSize: InventoryData.pageSize,
                onPageChange: (p) => setState(() => _currentPage = p.clamp(1, totalPages)),
                onRowTap: (rowData) {
                  // Navigate to inventory detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryDetailPage(
                        inventoryData: {
                          'bookingCode': rowData[0],
                          'dateIn': rowData[1],
                          'shipper': rowData[2],
                          'destination': rowData[3],
                          'quantity': rowData[4],
                          'marking': rowData[5],
                          'description': rowData[6],
                          'warehouseMeas': rowData[7],
                          'weight': rowData[8],
                          'pebNumber': rowData[9],
                          'pebDate': rowData[10],
                          'npeNumber': rowData[11],
                          'npeDate': rowData[12],
                          'value': rowData[13],
                          'currency': rowData[14],
                          'status': rowData[15],
                        },
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
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Stock Inventory",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(Icons.tune, color: Color(0xFF6B7280)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Search inventory...",
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF6B7280),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF374151),
                              width: 2,
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
                              color: Color(0xFF374151),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                  200, // Shipper - tetap panjang karena data panjang
                  100, // Destination
                  80,  // Quantity
                  80,  // Marking
                  110, // Description of Goods
                  90,  // Warehouse Meas
                  80,  // Weight (KGs)
                  100, // PEB Number
                  80,  // PEB Date
                  100, // NPE Number
                  80,  // NPE Date
                  60,  // Value
                  50,  // Currency
                  220, // Status - tetap panjang karena data panjang
                ],
                rows: InventoryData.stockInventoryTableData,
                emptyMessage: 'Showing Result',
                currentPage: 1,
                totalPages: (InventoryData.stockInventoryTableData.length / InventoryData.pageSize).ceil(),
                totalItems: InventoryData.stockInventoryTableData.length,
                pageSize: InventoryData.pageSize,
                onPageChange: (p) => setState(() => _currentPage = p),
                onRowTap: (rowData) {
                  // Navigate to inventory detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryDetailPage(
                        inventoryData: {
                          'bookingCode': rowData[0],
                          'dateIn': rowData[1],
                          'shipper': rowData[2],
                          'destination': rowData[3],
                          'quantity': rowData[4],
                          'marking': rowData[5],
                          'description': rowData[6],
                          'warehouseMeas': rowData[7],
                          'weight': rowData[8],
                          'pebNumber': rowData[9],
                          'pebDate': rowData[10],
                          'npeNumber': rowData[11],
                          'npeDate': rowData[12],
                          'value': rowData[13],
                          'currency': rowData[14],
                          'status': rowData[15],
                        },
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
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "List Cargo Out",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(Icons.tune, color: Color(0xFF6B7280)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Search cargo out...",
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF6B7280),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF374151),
                              width: 2,
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
                              color: Color(0xFF374151),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                  200, // Shipper - tetap panjang karena data panjang
                  100, // Destination
                  80,  // Quantity
                  80,  // Marking
                  110, // Description of Goods
                  90,  // Warehouse Meas
                  80,  // Weight (KGs)
                  100, // PEB Number
                  80,  // PEB Date
                  100, // NPE Number
                  80,  // NPE Date
                  60,  // Value
                  50,  // Currency
                  220, // Status - tetap panjang karena data panjang
                ],
                rows: InventoryData.cargoOutTableData,
                emptyMessage: 'Showing Result',
                currentPage: 1,
                totalPages: (InventoryData.cargoOutTableData.length / InventoryData.pageSize).ceil(),
                totalItems: InventoryData.cargoOutTableData.length,
                pageSize: InventoryData.pageSize,
                onPageChange: (p) => setState(() => _currentPage = p),
                onRowTap: (rowData) {
                  // Navigate to inventory detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryDetailCargoOutPage(
                        inventoryData: {
                          'bookingCode': rowData[0],
                          'dateIn': rowData[1],
                          'shipper': rowData[2],
                          'destination': rowData[3],
                          'quantity': rowData[4],
                          'marking': rowData[5],
                          'description': rowData[6],
                          'warehouseMeas': rowData[7],
                          'weight': rowData[8],
                          'pebNumber': rowData[9],
                          'pebDate': rowData[10],
                          'npeNumber': rowData[11],
                          'npeDate': rowData[12],
                          'value': rowData[13],
                          'currency': rowData[14],
                          'status': rowData[15],
                        },
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

  Widget _buildWarehouseLayoutTab() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with background similar to the image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF374151), // Dark background like in the image
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Warehouse Layout",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "View the detailed warehouse rack layout",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WarehouseLayoutPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A5568),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Open Warehouse Layout",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(IconData icon, String text, int index) {
    final bool isSelected = _tabController.index == index;
    
    // Determine the icon based on selection state
    IconData displayIcon;
    switch (index) {
      case 0: // Cargo In
        displayIcon = isSelected ? Icons.description : Icons.description_outlined;
        break;
      case 1: // Stock Inventory
        displayIcon = isSelected ? Icons.home_work : Icons.home_work_outlined;
        break;
      case 2: // Cargo Out
        displayIcon = isSelected ? Icons.local_shipping : Icons.local_shipping_outlined;
        break;
      default:
        displayIcon = icon;
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
          color: isSelected 
              ? Colors.white.withOpacity(0.2) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              displayIcon,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomLayoutTab(int index) {
    final bool isSelected = _tabController.index == index;
    
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
          color: isSelected 
              ? Colors.white.withOpacity(0.2) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Custom icon container like in the image
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent, // Slight background when selected
                border: Border.all(
                  color: Colors.white, 
                  width: isSelected ? 3 : 2, // Thicker border when selected
                ), 
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                isSelected ? Icons.add_circle : Icons.add, // Different icon when selected
                color: Colors.white,
                size: 20,
              ),
            ),
            // const SizedBox(width: 8),
            // Text(
            //   "Layout",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 14,
            //     fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            //   ),
            //   textAlign: TextAlign.left,
            // ),
          ],
        ),
      ),
    );
  }
}