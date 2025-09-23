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
                          // Row(
                          //   children: [
                          //     Container(
                          //       width: 4,
                          //       height: 24,
                          //       decoration: BoxDecoration(
                          //         color: const Color(0xFF6B7280),
                          //         borderRadius: BorderRadius.circular(2),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 16),
                          //     const Text(
                          //       "Layout Overview",
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   ],
                          // ),
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
                Row(
                  children: [
                    // GTW Code
                    Expanded(
                      flex: 3,
                      child: Text(
                        item['gtwCode']!,
                        style: const TextStyle(
                          color: Color(0xFFFFF100),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
                Row(
                  children: [
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
    final List<Map<String, dynamic>> rackItems = [
      {'name': 'Rack Line 1', 'items': '30 Items'},
      {'name': 'Rack Line 2', 'items': '88 Items'},
      {'name': 'Rack Line 3', 'items': '24 Items'},
      {'name': 'Rack Line 4', 'items': '14 Items'},
      {'name': 'Rack Line 5', 'items': '8 Items'},
      {'name': 'Rack Line 6', 'items': '7 Items'},
      {'name': 'Rack Line 7', 'items': '0 Items'},
      {'name': 'Rack Line 8', 'items': '2 Items'},
      {'name': 'Rack Line 9', 'items': '0 Items'},
      {'name': 'Rack Line 10', 'items': '1 Items'},
      {'name': 'Temporary Location Floor 3', 'items': '174 Items'},
      {'name': 'Temporary Location Floor 4', 'items': '489 Items'},
      {'name': 'Temporary Location Floor 5', 'items': '16 Items'},
      {'name': 'Temporary Location Floor 6', 'items': '39 Items'},
      {'name': 'Temporary Location Floor 7', 'items': '0 Items'},
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
    return SizedBox(
      height: 950, // Height yang cukup untuk menampilkan semua elemen
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Hanya scroll horizontal
        child: Container(
          width: 950, // Lebar yang cukup untuk seluruh layout
          height: 950, // Height untuk menampilkan semua elemen tanpa terpotong
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

              // Build warehouse layout exactly like the design
              ..._buildAccurateWarehouseLayout(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAccurateWarehouseLayout() {
    List<Widget> sections = [];

    // LEFT SIDE - Temp Location Side Floor A (vertikal panjang)
    sections.add(
      _buildRackWidget(
        "Temp. Location Side Floor A\n9", 
        20, 120, 60, 300, // Adjust height untuk kompak
        Colors.blue[300]!
      ),
    );

    // LEFT SIDE - Rack Line 9 (vertikal)
    sections.add(
      _buildRackWidget(
        "Rack Line 9\n0", 
        90, 120, 80, 300, // Adjust height
        const Color(0xFFFFC107)
      ),
    );

    // LEFT SIDE - Temp Location Side Floor B (vertikal) - Sesuaikan untuk match gambar
    sections.add(
      _buildRackWidget(
        "Temp. Location Side Floor B\n32", 
        20, 450, 60, 200, // Adjust position dan height
        Colors.blue[300]!
      ),
    );

    // LEFT SIDE - Rack Line 3 (vertikal) - Sesuaikan posisi untuk match gambar
    sections.add(
      _buildRackWidget(
        "Rack Line 3\n24", 
        90, 450, 80, 200, // Adjust position dan height
        const Color(0xFFFFC107)
      ),
    );

    // BOTTOM LEFT - Quarantine Area
    sections.add(
      _buildRackWidget(
        "Quarantine Area\n35", 
        90, 760, 80, 70, // Adjust position
        Colors.green[400]!
      ),
    );

    // BOTTOM - Rack Line 2
    sections.add(
      _buildRackWidget(
        "Rack Line 2\n88",
        190, 780, 120, 50,
        const Color(0xFFFFC107)
      ),
    );

    // BOTTOM - Temporary Location Front Floor (horizontal panjang)
    sections.add(
      _buildRackWidget(
        "Temporary Location Front Floor\n270", 
        190, 850, 400, 60, // Adjust height untuk lebih kompak
        Colors.pink[300]!
      ),
    );

    // CENTER-LEFT - Temporary Location Floor 3 (persegi besar)
    sections.add(
      _buildRackWidget(
        "Temporary Location Floor 3\n174", 
        200, 500, 150, 200, // Adjust position untuk lebih kompak
        Colors.pink[300]!
      ),
    );

    // CENTER - Rack Line 5
    sections.add(
      _buildRackWidget(
        "Rack Line 5\n8", 
        370, 500, 120, 70, // Adjust height
        const Color(0xFFFFC107)
      ),
    );

    // CENTER - Temp. Loc. Floor 5
    sections.add(
      _buildRackWidget(
        "Temp. Loc. Floor 5\n16", 
        370, 580, 120, 50, // Adjust position dan height
        Colors.pink[300]!
      ),
    );

    // CENTER - Rack Line 4
    sections.add(
      _buildRackWidget(
        "Rack Line 4\n14", 
        370, 640, 120, 50, // Adjust position
        const Color(0xFFFFC107)
      ),
    );

    // CENTER - Temp. Loc. Floor 4
    sections.add(
      _buildRackWidget(
        "Temp. Loc. Floor 4\n489", 
        370, 700, 120, 50, // Adjust position
        Colors.pink[300]!
      ),
    );

    // CENTER-UPPER - Temporary Location Floor 6
    sections.add(
      _buildRackWidget(
        "Temporary Location Floor 6\n39", 
        200, 330, 150, 60,
        Colors.pink[300]!
      ),
    );

    // CENTER-UPPER - Rack Line 6
    sections.add(
      _buildRackWidget(
        "Rack Line 6\n7", 
        370, 330, 120, 60,
        const Color(0xFFFFC107)
      ),
    );

    // UPPER - Rack Line 7
    sections.add(
      _buildRackWidget(
        "Rack Line 7\n0", 
        200, 270, 150, 50, 
        const Color(0xFFFFC107)
      ),
    );

    // UPPER - Rack Line 8
    sections.add(
      _buildRackWidget(
        "Rack Line 8\n2", 
        200, 210, 150, 50,
        const Color(0xFFFFC107)
      ),
    );

    // UPPER - Temp. Loc. Floor 7
    sections.add(
      _buildRackWidget(
        "Temp. Loc. Floor 7\n0", 
        370, 210, 120, 50,
        Colors.pink[300]!
      ),
    );

    // TOP - Temporary Location Floor 10
    sections.add(
      _buildRackWidget(
        "Temporary Location Floor 10\n35", 
        200, 120, 290, 50,
        Colors.pink[300]!
      ),
    );

    // TOP - Rack Line 10
    sections.add(
      _buildRackWidget(
        "Rack Line 10\n1", 
        200, 60, 180, 50, 
        const Color(0xFFFFC107)
      ),
    );

    // TOP RIGHT - Loading Area
    sections.add(
      _buildRackWidget(
        "Loading Area\n0", 
        520, 40, 100, 140,
        Colors.orange[400]!
      ),
    );

    // TOP RIGHT - Back Door
    sections.add(
      _buildRackWidget(
        "Back Door", 
        640, 40, 80, 100,
        Colors.grey[400]!
      ),
    );

    // RIGHT SIDE - Rack Line 1 (vertikal panjang di kanan)
    sections.add(
      _buildRackWidget(
        "Rack Line 1\n30", 
        750, 300, 120, 350,
        const Color(0xFFFFC107)
      ),
    );

    // BOTTOM RIGHT - Front Door
    sections.add(
      _buildRackWidget(
        "Front Door", 
        640, 850, 120, 60,
        Colors.grey[600]!
      ),
    );

    // BOTTOM CENTER - Pedestrian Door
    sections.add(
      _buildRackWidget(
        "Pedestrian Door", 
        320, 920, 150, 25,
        Colors.grey[600]!
      ),
    );

    // LEFT SIDE - Side Door
    sections.add(
      _buildRackWidget(
        "Side Door", 
        20, 430, 60, 15,
        Colors.grey[600]!
      ),
    );

    // Add location label at the top
    sections.add(
      Positioned(
        top: 10,
        left: 400,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(8),
          //   border: Border.all(color: Colors.grey[300]!),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black.withOpacity(0.1),
          //       blurRadius: 4,
          //       offset: const Offset(0, 2),
          //     ),
          //   ],
          // ),
          // child: Column(
          //   children: [
          //     const Text(
          //       "Location",
          //       style: TextStyle(
          //         fontSize: 11,
          //         color: Colors.grey,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //     const SizedBox(height: 2),
          //     Text(
          //       selectedLocation,
          //       style: const TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ],
          // ),
        ),
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
    // Extract rack name and number from label
    List<String> parts = label.split('\n');
    String rackName = parts[0];
    String rackNumber = parts.length > 1 ? parts[1] : '';
    
    // Determine if this is a special area (door, etc.)
    bool isDoor = rackName.toLowerCase().contains('door');
    bool isRackLine = rackName.toLowerCase().contains('rack line');
    bool isTempLocation = rackName.toLowerCase().contains('temp');
    bool isQuarantine = rackName.toLowerCase().contains('quarantine');
    bool isLoading = rackName.toLowerCase().contains('loading');
    
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
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isDoor ? Colors.black54 : Colors.white, 
              width: isDoor ? 1 : 2
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            child: _buildRackContent(rackName, rackNumber, width, height, color, isRackLine, isTempLocation, isDoor, isQuarantine, isLoading),
          ),
        ),
      ),
    );
  }

  Widget _buildRackContent(String rackName, String rackNumber, double width, double height, Color bgColor, bool isRackLine, bool isTempLocation, bool isDoor, bool isQuarantine, bool isLoading) {
    Color textColor = _getTextColor(bgColor);
    double fontSize = _getFontSize(width, height);
    
    if (isDoor) {
      return Center(
        child: Text(
          rackName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize - 1,
          ),
        ),
      );
    }
    
    if (isRackLine) {
      // Format khusus untuk Rack Line seperti di gambar
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (height > 50) ...[
            Text(
              rackName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            const SizedBox(height: 2),
          ],
          if (rackNumber.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                rackNumber,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize + 4,
                ),
              ),
            ),
        ],
      );
    }
    
    if (isTempLocation || isQuarantine || isLoading) {
      // Format untuk temporary location dan area khusus lainnya
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              rackName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize - 1,
              ),
              maxLines: height > 100 ? 3 : 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (rackNumber.isNotEmpty && rackNumber != '0') ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: bgColor, width: 1),
              ),
              child: Text(
                rackNumber,
                style: TextStyle(
                  color: bgColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize + 2,
                ),
              ),
            ),
          ],
        ],
      );
    }
    
    // Default format
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            rackName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          if (rackNumber.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              rackNumber,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize + 2,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Helper method to get appropriate text color based on background
  Color _getTextColor(Color backgroundColor) {
    // Calculate luminance to determine if text should be light or dark
    double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  // Helper method to get appropriate font size based on widget dimensions
  double _getFontSize(double width, double height) {
    double minDimension = width < height ? width : height;
    if (minDimension < 60) return 7;
    if (minDimension < 80) return 8;
    if (minDimension < 100) return 9;
    if (minDimension < 120) return 10;
    if (minDimension < 150) return 11;
    return 12;
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
    // Clean up the rack name to match with data
    String cleanRackName = rackName.split('\n')[0];
    
    // Handle specific naming differences
    if (cleanRackName.contains('Temp. Loc.')) {
      cleanRackName = cleanRackName.replaceAll('Temp. Loc.', 'Temporary Location');
    }
    
    final rack = WarehouseData.rackData['racks'].firstWhere(
      (r) => r['id'].toString().toLowerCase().contains(cleanRackName.toLowerCase()) ||
             cleanRackName.toLowerCase().contains(r['id'].toString().toLowerCase()),
      orElse: () => {'items': 0},
    );
    return rack['items'] ?? 0;
  }
}
