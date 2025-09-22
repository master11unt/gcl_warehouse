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
  Set<int> expandedRackItems = {}; // Track which rack items are expanded

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
                          const SizedBox(height: 12),
                          
                          // Horizontal line
                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          
                          const SizedBox(height: 20),

                          // Search Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search...",
                                hintStyle: const TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xFF6B7280),
                                  size: 20,
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

                    // Rack List
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: _buildModernRackList(),
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

  // Generate sample dropdown data based on the provided image
  List<Map<String, String>> _getDropdownDataForRack(String rackName) {
    // Sample data matching the image format
    return [
      {
        'gtwCode': 'GTW-20250207052451',
        'company': 'UNIAIR INDOTAMA CARGO, PT',
        'quantity': '2 PALLETS',
        'destination': 'KEELUNG (CHILUNG)'
      },
      {
        'gtwCode': 'GTW-20250211030718',
        'company': 'NARUMI INDONESIA, PT',
        'quantity': '5 PALLETS',
        'destination': 'LOS ANGELES'
      },
      {
        'gtwCode': 'GTW-20250212032324',
        'company': 'NARUMI INDONESIA, PT',
        'quantity': '2 PALLETS',
        'destination': 'SHANGHAI'
      },
      {
        'gtwCode': 'GTW-20250207032804',
        'company': 'NARUMI INDONESIA, PT',
        'quantity': '23 CARTONS',
        'destination': 'HONG KONG'
      },
      {
        'gtwCode': 'GTW-20250210044929',
        'company': 'YAMATO INDONESIA FORWARDING, PT',
        'quantity': '2 PALLETS',
        'destination': 'MANZANILLO'
      },
      {
        'gtwCode': 'GTW-20250213040108',
        'company': 'YAMATO INDONESIA FORWARDING, PT',
        'quantity': '3 PACKAGES',
        'destination': 'LAEM CHABANG'
      },
      {
        'gtwCode': 'GTW-20250212015407',
        'company': 'YAMATO INDONESIA FORWARDING, PT',
        'quantity': '2 PALLETS',
        'destination': 'BANGKOK'
      },
    ];
  }

  Widget _buildDropdownContent(String rackName) {
    List<Map<String, String>> dropdownData = _getDropdownDataForRack(rackName);
    
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1F2937), // Dark background like in the image
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        children: dropdownData.map((item) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF4A5568),
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                // First row: GTW Code and Quantity
                Row(
                  children: [
                    // GTW Code
                    Expanded(
                      flex: 3,
                      child: Text(
                        item['gtwCode']!,
                        style: const TextStyle(
                          color: Color(0xFFFFEB3B), // Yellow color
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Quantity
                    Expanded(
                      flex: 1,
                      child: Text(
                        item['quantity']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Second row: Company and Destination
                Row(
                  children: [
                    // Company
                    Expanded(
                      flex: 3,
                      child: Text(
                        item['company']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    // Destination
                    Expanded(
                      flex: 1,
                      child: Text(
                        item['destination']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModernRackList() {
    // Data rack sesuai dengan gambar
    final List<Map<String, dynamic>> rackItems = [
      {'name': 'Rack Line 1', 'items': '30 Items'},
      {'name': 'Rack Line 2', 'items': '88 Items'},
      {'name': 'Rack Line 3', 'items': '24 Items'},
      {'name': 'Rack Line 4', 'items': '14 Items'},
      {'name': 'Rack Line 5', 'items': '8 Items'},
      {'name': 'Rack Line 6', 'items': '7 Items'},
      {'name': 'Rack Line 8', 'items': '2 Items'},
      {'name': 'Rack Line 10', 'items': '1 Items'},
      {'name': 'Temporary Location Floor 3', 'items': '169 Items'},
      {'name': 'Temporary Location Floor 4', 'items': '483 Items'},
      {'name': 'Temporary Location Floor 5', 'items': '16 Items'},
      {'name': 'Temporary Location Floor 6', 'items': '39 Items'},
      {'name': 'Temporary Location Floor 10', 'items': '35 Items'},
      {'name': 'Temporary Location Front Floor', 'items': '270 Items'},
      {'name': 'Temporary Location Side Floor A', 'items': '9 Items'},
      {'name': 'Temporary Location Side Floor B', 'items': '32 Items'},
      {'name': 'Quarantine Area', 'items': '35 Items'},
      {'name': 'Not In Rack', 'items': '59 Items'},
    ];

    return Column(
      children: rackItems.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> item = entry.value;
        bool isExpanded = expandedRackItems.contains(index);
        
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: item['name'],
                        style: const TextStyle(
                          color: Color(0xFF4A5568),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' - ${item['items']}',
                        style: const TextStyle(
                          color: Color(0xFF718096),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: const Color(0xFF4A5568),
                  size: 20,
                ),
                onTap: () {
                  setState(() {
                    if (isExpanded) {
                      expandedRackItems.remove(index);
                    } else {
                      expandedRackItems.add(index);
                    }
                  });
                },
              ),
              // Dropdown content with animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: isExpanded ? null : 0,
                child: isExpanded ? _buildDropdownContent(item['name']) : const SizedBox(),
              ),
            ],
          ),
        );
      }).toList(),
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
