import 'package:flutter/material.dart';
import '../widgets/home/custom_drawer.dart';
import '../widgets/common/common_app_bar.dart';
import '../models/warehouse_data.dart';

class WarehouseLayoutPage extends StatefulWidget {
  @override
  _WarehouseLayoutPageState createState() => _WarehouseLayoutPageState();
}

class _WarehouseLayoutPageState extends State<WarehouseLayoutPage> {
  String selectedLocation = 'Marunda';
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CommonAppBar(),
      drawer: CustomDrawer(currentPage: "rack"),
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
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedLocation,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: Colors.grey[200],
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F2937),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Not in Rack",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${WarehouseData.rackData['Not In Rack']}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Layout Overview section
                    Padding(
                      padding: const EdgeInsets.all(20),
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
                                "Layout Overview",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Interactive Layout Grid
                          _buildInteractiveLayout(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Options Header with Search
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Options",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Search Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xFF6B7280),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Integrated Rack Details List
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: _buildCompactRackList(),
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

  Widget _buildCompactRackList() {
    // Menggunakan data dari WarehouseData model
    final List<Map<String, dynamic>> rackCategories =
        WarehouseData.rackCategories;

    return StatefulBuilder(
      builder: (context, setExpansionState) {
        return Column(
          children:
              rackCategories.asMap().entries.map<Widget>((entry) {
                final index = entry.key;
                final category = entry.value;

                return Column(
                  children: [
                    // Smaller grey container for category title
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ), // Much smaller padding
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          3,
                        ), // Even smaller radius
                      ),
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          iconColor: Colors.grey[600],
                          collapsedIconColor: Colors.grey[600],
                          onExpansionChanged: (expanded) {
                            setExpansionState(() {
                              rackCategories[index]['isExpanded'] = expanded;
                            });
                          },
                          initiallyExpanded: category['isExpanded'] as bool,
                          title: Row(
                            children: [
                              // Yellow line indicator
                              Container(
                                width: 2,
                                height: 12, // Even smaller height
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD700),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  category['title'] as String,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                category['count'] as String,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          children:
                              (category['bookings'] as List).isEmpty
                                  ? []
                                  : [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 4,
                                        bottom: 8,
                                      ),
                                      constraints: const BoxConstraints(
                                        maxHeight: 200,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1F2937),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children:
                                              (category['bookings'] as List).asMap().entries.map<
                                                Widget
                                              >((bookingEntry) {
                                                final bookingIndex =
                                                    bookingEntry.key;
                                                final booking =
                                                    bookingEntry.value;
                                                final isLast =
                                                    bookingIndex ==
                                                    (category['bookings']
                                                                as List)
                                                            .length -
                                                        1;

                                                return Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            12,
                                                          ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Booking code
                                                          Text(
                                                            booking['code']
                                                                as String,
                                                            style:
                                                                const TextStyle(
                                                                  color: Color(
                                                                    0xFFFFD700,
                                                                  ),
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          // Company/Type
                                                          Text(
                                                            booking['type']
                                                                as String,
                                                            style:
                                                                const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                booking['info']
                                                                    as String,
                                                                style: const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white70,
                                                                  fontSize: 9,
                                                                ),
                                                              ),
                                                              Text(
                                                                booking['destination']
                                                                    as String,
                                                                style: const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white70,
                                                                  fontSize: 9,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if (!isLast)
                                                      Container(
                                                        height: 1,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                        margin:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                            ),
                                                      ),
                                                  ],
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildInteractiveLayout() {
    return Container(
      height: 600,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Container(
            width: 800,
            height: 1200,
            child: Stack(
              children: [
                // Background
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                ),

                // Side Door Area
                Positioned(
                  left: 20,
                  top: 100,
                  child: Container(
                    width: 80,
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Temp. Location Side Floor A",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Build rack sections
                ..._buildRackSections(),

                // Pedestrian Door
                Positioned(
                  bottom: 20,
                  left: 350,
                  right: 350,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        "Pedestrian Door",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRackSections() {
    List<Widget> sections = [];

    // Top section racks
    sections.add(
      _buildRackWidget("Rack Line 10\n1", 150, 50, 200, 80, Colors.orange),
    );
    sections.add(
      _buildRackWidget(
        "Temporary Location\nFloor 10\n35",
        350,
        50,
        200,
        80,
        Colors.pink[300]!,
      ),
    );
    sections.add(
      _buildRackWidget("Rack Line 8\n2", 150, 150, 150, 60, Colors.orange),
    );
    sections.add(
      _buildRackWidget(
        "Temp. Loc.\nFloor 7\n0",
        300,
        150,
        120,
        60,
        Colors.pink[300]!,
      ),
    );
    sections.add(
      _buildRackWidget("Rack Line 7\n0", 150, 220, 150, 60, Colors.orange),
    );

    // Middle section
    sections.add(
      _buildRackWidget("Rack Line 6\n7", 500, 400, 120, 80, Colors.orange),
    );
    sections.add(
      _buildRackWidget(
        "Temporary\nLocation\nFloor 6\n39",
        420,
        500,
        100,
        120,
        Colors.pink[300]!,
      ),
    );

    // Lower middle section
    sections.add(
      _buildRackWidget("Rack Line 5\n8", 500, 650, 120, 80, Colors.orange),
    );
    sections.add(
      _buildRackWidget(
        "Temp. Loc.\nFloor 5\n12",
        420,
        750,
        100,
        60,
        Colors.pink[300]!,
      ),
    );
    sections.add(
      _buildRackWidget("Rack Line 4\n15", 420, 820, 120, 60, Colors.orange),
    );
    sections.add(
      _buildRackWidget(
        "Temp. Loc.\nFloor 4\n283",
        420,
        890,
        120,
        60,
        Colors.pink[300]!,
      ),
    );
    sections.add(
      _buildRackWidget(
        "Temporary\nLocation\nFloor 3\n151",
        300,
        900,
        100,
        120,
        Colors.pink[300]!,
      ),
    );

    // Bottom section
    sections.add(
      _buildRackWidget("Rack Line 3\n21", 120, 800, 80, 200, Colors.orange),
    );
    sections.add(
      _buildRackWidget(
        "Quarantine\nArea\n31",
        120,
        1020,
        80,
        80,
        Colors.green[300]!,
      ),
    );
    sections.add(
      _buildRackWidget("Rack Line 2\n105", 220, 1020, 100, 60, Colors.orange),
    );
    sections.add(
      _buildRackWidget(
        "Temporary Location\nFront Floor\n234",
        250,
        1100,
        300,
        80,
        Colors.pink[300]!,
      ),
    );

    return sections;
  }

  Widget _buildRackWidget(
    String label,
    double left,
    double top,
    double width,
    double height,
    Color color,
  ) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          _showRackDetails(label);
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRackDetails(String rackName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rack Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Location: $rackName"),
              const SizedBox(height: 8),
              Text("Items: ${_getItemCount(rackName)}"),
              const SizedBox(height: 8),
              Text("Status: Available"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to detailed inventory
              },
              child: const Text("View Details"),
            ),
          ],
        );
      },
    );
  }

  int _getItemCount(String rackName) {
    final rack = WarehouseData.rackData['racks'].firstWhere(
      (r) => r['id'].contains(rackName.split('\n')[0]),
      orElse: () => {'items': 0},
    );
    return rack['items'];
  }
}
