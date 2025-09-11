import 'package:flutter/material.dart';
import '../widgets/home/custom_drawer.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/stuffing/stuffing_table.dart';
import '../models/stuffing_data.dart';
import 'stuffing_detail_page.dart';

class StuffingPage extends StatefulWidget {
  @override
  _StuffingPageState createState() => _StuffingPageState();
}

class _StuffingPageState extends State<StuffingPage> {
  String searchQuery = '';
  int currentPage = 1;
  String selectedFilter = 'all'; // 'all', 'ongoing', 'cleared'

  // Sample stuffing data berdasarkan filter dan search
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CommonAppBar(),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Combined Section - Title, Statistics Cards and List
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
                            width: 4,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6B7280),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            "Stuffing",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Statistics Cards Section
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Top row - 2 cards
                          Row(
                            children: [
                              // Ticket Stuffing Card
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
                                          "361",
                                          style: TextStyle(
                                            color:
                                                selectedFilter == 'all'
                                                    ? Colors.white
                                                    : Colors.black,
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
                                          "10",
                                          style: TextStyle(
                                            color:
                                                selectedFilter == 'ongoing'
                                                    ? Colors.white
                                                    : Colors.black,
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

                          // Bottom row - 1 card
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
                                          "967",
                                          style: TextStyle(
                                            color:
                                                selectedFilter == 'cleared'
                                                    ? Colors.white
                                                    : Colors.black,
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
                              // Empty space to maintain symmetry
                              const SizedBox(width: 12),
                              Expanded(child: Container()),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    Divider(height: 1, color: Colors.grey[200]),
                    // Section Header
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
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Search Field
                          Row(
                            children: [
                              Icon(Icons.tune, color: Colors.grey[600]),
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
                        columns: const [
                          'Job Number',
                          'Stuffing Date',
                          'Destination',
                          'ETD',
                          'Closing Date',
                          'Owner',
                          'Total Container',
                        ],
                        rows: displayedData,
                        columnWidths: const [
                          150, 
                          150, 
                          150, 
                          100, 
                          150,
                          150, 
                          150,
                        ],
                        currentPage: currentPage,
                        totalPages: totalPages,
                        totalItems: filteredStuffingData.length,
                        pageSize: StuffingData.itemsPerPage,
                        onPageChange: (page) {
                          setState(() {
                            currentPage = page;
                          });
                        },
                        onRowTap: (stuffingData) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StuffingDetailPage(
                                stuffingData: stuffingData,
                              ),
                            ),
                          );
                        },
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
