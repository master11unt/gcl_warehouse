import 'package:flutter/material.dart';
import '../widgets/home/custom_drawer.dart';
import '../widgets/ticket/ticket_table.dart';
import '../widgets/common/common_app_bar.dart';
import '../models/ticket_data.dart';
import 'ticket_cargo_in_detail_page.dart';
import 'ticket_stuffing_detail_page.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> with TickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  int _cargoInPage = 1;
  late final List<List<String>> _cargoInAllRows;
  int _stuffingPage = 1;
  late final List<List<String>> _stuffingAllRows;
  
  // Filter variables
  String _selectedCategory = 'None';
  String _selectedStatus = 'Valid';
  DateTime? _selectedDate;
  
  // Filter options
  final List<String> _categoryOptions = [
    'None', 'GCL-JAKARTA', 'GCL-BANDUNG', 'GCL-CIKARANG', 
    'OSLINE-JAKARTA', 'OSLINE-BANDUNG', 'BPLINE', 'WINFAST', 'LCL', 'FCL'
  ];
  final List<String> _statusOptions = ['Valid', 'Invalid', 'All'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _cargoInAllRows = TicketData.generateCargoInRows(TicketData.cargoInTotalCount);
    _stuffingAllRows = TicketData.generateStuffingRows(TicketData.stuffingTotalCount);
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
      drawer: CustomDrawer(currentPage: "ticket"),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              margin: const EdgeInsets.all(16),
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
              child: Row(
                children: const [
                  SizedBox(
                    width: 4,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Ticket",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Tab Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFB0B7C1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                indicatorPadding: EdgeInsets.zero,
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: const Color(0xFFF3F4F6),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                tabs: const [
                  SizedBox(
                    height: 46,
                    child: Center(child: Text("Ticket Cargo In")),
                  ),
                  SizedBox(
                    height: 46,
                    child: Center(child: Text("Ticket Stuffing")),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildTicketCargoInTab(), _buildTicketStuffingTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketCargoInTab() {
    // Apply filters to the data
    final filteredRows = _getFilteredRows(_cargoInAllRows);
    final totalItems = filteredRows.length;
    final totalPages = (totalItems + TicketData.cargoInPageSize - 1) ~/ TicketData.cargoInPageSize;
    final page = _cargoInPage.clamp(1, totalPages == 0 ? 1 : totalPages);
    final visibleRows = TicketData.paginateRows(filteredRows, page, TicketData.cargoInPageSize);

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        _buildCombinedSummaryOptionsTable(
          summaryTitle1: "Scheduled\nTicket",
          summaryValue1: "1904",
          summaryTitle2: "Checked-In\nTicket", 
          summaryValue2: "5938",
          showSecondSummary: true,
          tableColumns: const [
            'Booking Code',
            'Plan Date In',
            'Shipper',
            'Total',
            'Destination',
            'Cargo Owner',
            'Cargo Service Type',
            'Status',
          ],
          columnWidths: const [
            160, // Booking Code
            150, // Plan Date In
            140, // Shipper
            100,  // Total
            150, // Destination
            120, // Cargo Owner
            150, // Cargo Service Type
            100,  // Status
          ],
          tableRows: visibleRows,
          emptyMessage: 'Showing Result',
          currentPage: page,
          totalPages: totalPages,
          totalItems: totalItems,
          pageSize: TicketData.cargoInPageSize,
          onPageChange: (p) => setState(() => _cargoInPage = p.clamp(1, totalPages)),
          onRowTap: (row) {
            // Navigate to detail page with row data
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketCargoInDetailPage(
                  ticketData: {
                    'bookingCode': row[0],
                    'planDateIn': row[1],
                    'shipper': row[2],
                    'total': row[3],
                    'destination': row[4],
                    'cargoOwner': row[5],
                    'cargoServiceType': row[6],
                    'status': row[7],
                    // Add additional sample data for the detail page
                    'description': '15 BALES 2/32NM ACRYLIC 65% AND WOOL 35% YARN UNDYED',
                    'etd': '2025-01-25',
                    'containerNumber': '-',
                    'containerSize': '-',
                    'vessel': 'WAR HAI 377 V.W004',
                    'connectingVessel': '-',
                    'marking': 'SHINGORA B/NO. NHAVA SHEVA PT. ACHEM MADE IN INDONESIA',
                    'estimatedCargoIn': '2024-01-01 00:00:00',
                    'quantity': '15',
                    'package': 'BALES',
                    'weight': '1530',
                    'volume': '3.14',
                    'requestedBy': 'HERI',
                    'requestDate': '2025-01-22',
                    'rulesReference': 'GTW/SOP/JKT/122331',
                  },
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

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
            children: const [
              Text(
                "Rules",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Based On : GTW/SOP/JKT/122331",
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTicketStuffingTab() {
    final totalItems = _stuffingAllRows.length;
    final totalPages =
        (totalItems + TicketData.stuffingPageSize - 1) ~/ TicketData.stuffingPageSize;
    final page = _stuffingPage.clamp(1, totalPages == 0 ? 1 : totalPages);
    final visibleRows = TicketData.paginateRows(
      _stuffingAllRows,
      page,
      TicketData.stuffingPageSize,
    );

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        _buildCombinedSummaryOptionsTable(
          summaryTitle1: "Stuffing Ticket",
          summaryValue1: "342",
          summaryTitle2: "", // Not used since showSecondSummary is false
          summaryValue2: "",
          showSecondSummary: false,
          tableColumns: const [
            'Job Number',
            'Stuffing Date',
            'Destination',
            'ETD',
            'Closing Date',
            'Stuffing Owner',
            'Total Container Fill',
          ],
          columnWidths: const [
            160, // Job Number
            160, // Stuffing Date
            160, // Destination
            160, // ETD
            160, // Closing Date
            160, // Stuffing Owner
            160, // Total Container Fill
          ],
          tableRows: visibleRows,
          emptyMessage: 'Showing Result',
          currentPage: page,
          totalPages: totalPages,
          totalItems: totalItems,
          pageSize: TicketData.stuffingPageSize,
          onPageChange: (p) => setState(() => _stuffingPage = p.clamp(1, totalPages)),
          onRowTap: (rowData) {
            // Navigate to stuffing detail page
            final stuffingData = {
              'jobNumber': rowData[0], // Job Number
              'stuffingDate': rowData[1], // Stuffing Date
              'destination': rowData[2], // Destination
              'etd': rowData[3], // ETD
              'closingDate': rowData[4], // Closing Date
              'stuffingOwner': rowData[5], // Stuffing Owner
              'totalContainerFill': rowData[6], // Total Container Fill
              'containerNumber': 'KOCU5009373 / 24H0102212',
              'containerSize': '40HC',
              'vessel': 'HMM MIRACLE V 009N',
              'agent': 'PORTSHA',
              'requestedBy': 'SITI AISYAH',
              'requestDate': '2025-07-24',
              'rulesReference': 'GTW/SOP/JKT/122331',
            };
            
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketStuffingDetailPage(
                  ticketData: stuffingData,
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

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
            children: const [
              Text(
                "Rules",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Based On : GTW/SOP/JKT/122331",
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSummaryItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildCombinedSummaryOptionsTable({
    required String summaryTitle1,
    required String summaryValue1,
    required String summaryTitle2,
    required String summaryValue2,
    required List<String> tableColumns,
    required List<double> columnWidths,
    required List<List<String>> tableRows,
    required String emptyMessage,
    required int currentPage,
    required int totalPages,
    required int totalItems,
    required int pageSize,
    required Function(int) onPageChange,
    required Function(List<String>) onRowTap,
    bool showSecondSummary = true,
  }) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Section
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(summaryValue1, summaryTitle1),
              ),
              if (showSecondSummary) ...[
                Container(
                  width: 1,
                  height: 72,
                  color: const Color(0xFFE5E7EB),
                ),
                Expanded(
                  child: _buildSummaryItem(summaryValue2, summaryTitle2),
                ),
              ],
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Options Section
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
                "Options",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF6B7280),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
          
          const SizedBox(height: 32),
          
          // Table Section
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "List",
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
              PopupMenuButton<String>(
                onSelected: (value) {
                  // Handle filter selection
                },
                icon: const Icon(Icons.tune, color: Color(0xFF6B7280)),
                color: Colors.white,
                surfaceTintColor: Colors.white,
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    enabled: false,
                    child: Container(
                      width: 320,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Time Filter Section
                          const Text(
                            'Time Filter',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFF374151),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: _selectedDate ?? DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2030),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      _selectedDate = picked;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _selectedDate != null
                                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                              : 'Select Date',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            height: 36,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _categoryOptions.map((category) {
                                  final isSelected = _selectedCategory == category;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedCategory = category;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: isSelected ? const Color(0xFF374151) : Colors.white,
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: const Color(0xFFE5E7EB),
                                          ),
                                        ),
                                        child: Text(
                                          category,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : const Color(0xFF374151),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Status Filter
                          const Text(
                            'Status Filter',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: _statusOptions.map((status) {
                              final isSelected = _selectedStatus == status;
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedStatus = status;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFF374151) : Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: const Color(0xFFE5E7EB),
                                      ),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : const Color(0xFF374151),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
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
                    onChanged: (value) => setState(() => searchQuery = value),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          TicketTable(
            columns: tableColumns,
            columnWidths: columnWidths,
            rows: tableRows,
            emptyMessage: emptyMessage,
            currentPage: currentPage,
            totalPages: totalPages,
            totalItems: totalItems,
            pageSize: pageSize,
            onPageChange: onPageChange,
            onRowTap: onRowTap,
          ),
        ],
      ),
    );
  }

  // Helper method to filter table rows based on selected filters
  List<List<String>> _getFilteredRows(List<List<String>> allRows) {
    return allRows.where((row) {
      bool categoryMatch = true;
      bool statusMatch = true;
      bool dateMatch = true;
      
      // Category filter logic (assuming category is in a specific column - adjust index as needed)
      if (_selectedCategory != 'None') {
        // For cargo in, you might want to check shipper (column 2) or cargo service type (column 6)
        categoryMatch = row.length > 6 && 
            (row[2].toLowerCase().contains(_selectedCategory.toLowerCase()) ||
             row[6].toLowerCase().contains(_selectedCategory.toLowerCase()));
      }
      
      // Status filter logic (assuming status is in the last column)
      if (_selectedStatus != 'All') {
        statusMatch = row.length > 7 && 
            row[7].toLowerCase().contains(_selectedStatus.toLowerCase());
      }
      
      // Date filter logic (assuming date is in column 1 - Plan Date In)
      if (_selectedDate != null && row.length > 1) {
        try {
          // Parse the date from the row (assuming format like "2024-01-01")
          final rowDateParts = row[1].split('-');
          if (rowDateParts.length == 3) {
            final rowDate = DateTime(
              int.parse(rowDateParts[0]),
              int.parse(rowDateParts[1]),
              int.parse(rowDateParts[2]),
            );
            final selectedDateOnly = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day);
            final rowDateOnly = DateTime(rowDate.year, rowDate.month, rowDate.day);
            dateMatch = selectedDateOnly.isAtSameMomentAs(rowDateOnly);
          }
        } catch (e) {
          dateMatch = false;
        }
      }
      
      return categoryMatch && statusMatch && dateMatch;
    }).toList();
  }

}
