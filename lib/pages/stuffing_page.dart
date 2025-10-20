import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';
import '../widgets/home/custom_drawer.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/stuffing/stuffing_table.dart';
import '../models/stuffing_data.dart';
import 'ticket_stuffing_detail_page.dart';
import 'stuffing_ongoing_detail_page.dart';
import 'stuffing_cleared_detail_page.dart';

class StuffingPage extends StatefulWidget {
  @override
  _StuffingPageState createState() => _StuffingPageState();
}

class _StuffingPageState extends State<StuffingPage> {
  String searchQuery = '';
  int currentPage = 1;
  String selectedFilter = 'all';

  List<Map<String, dynamic>> get filteredStuffingData {
    return StuffingData.searchData(searchQuery, selectedFilter);
  }

  int get totalPages {
    return StuffingData.getTotalPages(
      filteredStuffingData.length,
      StuffingData.itemsPerPage,
    );
  }

  List<Map<String, dynamic>> get displayedData {
    return StuffingData.paginateData(
      filteredStuffingData,
      currentPage,
      StuffingData.itemsPerPage,
    );
  }

  List<String> get currentTableColumns =>
      StuffingData.getTableColumns(selectedFilter);
  List<double> get currentColumnWidths =>
      StuffingData.getColumnWidths(selectedFilter);

  void _handleRowTap(Map<String, dynamic> stuffingData) {
    switch (selectedFilter) {
      case 'all':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => TicketStuffingDetailPage(ticketData: stuffingData),
          ),
        );
        break;
      case 'ongoing':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    StuffingOngoingDetailPage(stuffingData: stuffingData),
          ),
        );
        break;
      case 'cleared':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    StuffingClearedDetailPage(stuffingData: stuffingData),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CommonAppBar(),
      drawer: CustomDrawer(currentPage: "stuffing"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
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
                    // Title Section
                    Padding(
                      padding: const EdgeInsets.all(20),
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
                          const Text(
                            "Stuffing",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = 'all';
                                      currentPage = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedFilter == 'all'
                                              ? const Color(0xFF4A5568)
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          selectedFilter == 'all'
                                              ? null
                                              : Border.all(
                                                color: Colors.grey[200]!,
                                                width: 1,
                                              ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          StuffingData.getCount(
                                            'all',
                                          ).toString(),
                                          style: TextStyle(
                                            color:
                                                selectedFilter == 'all'
                                                    ? Colors.white
                                                    : Color(0xFF0F172A),
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Ticket Stuffing",
                                          style: TextStyle(
                                            color:
                                                selectedFilter == 'all'
                                                    ? Colors.white.withOpacity(
                                                      0.8,
                                                    )
                                                    : Colors.grey[600],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // On Going Card
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = 'ongoing';
                                      currentPage = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedFilter == 'ongoing'
                                              ? const Color(0xFF4A5568)
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          selectedFilter == 'ongoing'
                                              ? null
                                              : Border.all(
                                                color: Colors.grey[200]!,
                                                width: 1,
                                              ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          StuffingData.getCount(
                                            'ongoing',
                                          ).toString(),
                                          style: TextStyle(
                                            color:
                                                selectedFilter == 'ongoing'
                                                    ? Colors.white
                                                    : Color(0xFF0F172A),
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "On Going",
                                          style: TextStyle(
                                            color:
                                                selectedFilter == 'ongoing'
                                                    ? Colors.white.withOpacity(
                                                      0.8,
                                                    )
                                                    : Colors.grey[600],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                              // Cleared Card
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = 'cleared';
                                      currentPage = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedFilter == 'cleared'
                                              ? const Color(0xFF4A5568)
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          selectedFilter == 'cleared'
                                              ? null
                                              : Border.all(
                                                color: Colors.grey[200]!,
                                                width: 1,
                                              ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          StuffingData.getCount(
                                            'cleared',
                                          ).toString(),
                                          style: TextStyle(
                                            color:
                                                selectedFilter == 'cleared'
                                                    ? Colors.white
                                                    : Color(0xFF0F172A),
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Cleared",
                                          style: TextStyle(
                                            color:
                                                selectedFilter == 'cleared'
                                                    ? Colors.white.withOpacity(
                                                      0.8,
                                                    )
                                                    : Colors.grey[600],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(child: Container()),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    // Divider(height: 1, color: Colors.grey[200]),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "List Stuffing Plan Ticket",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              SvgIcon(
                                assetPath: 'assets/icons/filter_outline.svg',
                                color: Color(0xFF6B7280),
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[300]!,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "Search..",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        searchQuery = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Stuffing Table
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: StuffingTable(
                        columns: currentTableColumns,
                        rows: displayedData,
                        columnWidths: currentColumnWidths,
                        currentPage: currentPage,
                        totalPages: totalPages,
                        totalItems: filteredStuffingData.length,
                        pageSize: StuffingData.itemsPerPage,
                        onPageChange: (page) {
                          setState(() {
                            currentPage = page;
                          });
                        },
                        onRowTap: _handleRowTap,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
