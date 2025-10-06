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
  Set<int> expandedRackItems = {};

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
                            color: const Color(0xFF0F172A),
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
                          const SizedBox(height: 20),

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
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
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
                          
                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          
                          const SizedBox(height: 20),

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

  // Ambil data dropdown dari models
  List<Map<String, String>> _getDropdownDataForRack(String rackName) {
    // Jika ingin filter, bisa modifikasi di warehouse_data.dart
    return warehouseDropdownData;
  }

  Widget _buildDropdownContent(String rackName) {
    List<Map<String, String>> dropdownData = _getDropdownDataForRack(rackName);
    
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
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
    // Ambil rackItems dari models
    return Column(
      children: warehouseRackItems.asMap().entries.map((entry) {
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
      height: 950,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 950,
          height: 950,
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

              ..._buildAccurateWarehouseLayout(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAccurateWarehouseLayout() {
    List<Widget> sections = [];

    // LEFT SIDE
    sections.add(
      _buildRackWidget(
        "Temp. Location Side Floor A\n9", 
        20, 120, 60, 300,
        Colors.blue[300]!
      ),
    );

    // LEFT SIDE - Rack Line 9 (vertikal)
    sections.add(
      _buildRackWidget(
        "Rack Line 9\n0", 
        90, 120, 80, 300,
        const Color(0xFFFFC107)
      ),
    );

    // LEFT SIDE - Temp Location Side Floor B (vertikal)
    sections.add(
      _buildRackWidget(
        "Temp. Location Side Floor B\n32", 
        20, 450, 60, 200,
        Colors.blue[300]!
      ),
    );

    // LEFT SIDE - Rack Line 3 (vertikal)
    sections.add(
      _buildRackWidget(
        "Rack Line 3\n24", 
        90, 450, 80, 200,
        const Color(0xFFFFC107)
      ),
    );

    // BOTTOM LEFT - Quarantine Area
    sections.add(
      _buildRackWidget(
        "Quarantine Area\n35", 
        90, 760, 80, 70,
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

    // BOTTOM - Temporary Location Front Floor
    sections.add(
      _buildRackWidget(
        "Temporary Location Front Floor\n270", 
        190, 850, 400, 60,
        Colors.pink[300]!
      ),
    );

    // CENTER-LEFT - Temporary Location Floor 3
    sections.add(
      _buildRackWidget(
        "Temporary Location Floor 3\n174", 
        200, 500, 150, 200,
        Colors.pink[300]!
      ),
    );

    // CENTER - Rack Line 5
    sections.add(
      _buildRackWidget(
        "Rack Line 5\n8", 
        370, 500, 120, 70,
        const Color(0xFFFFC107)
      ),
    );

    // CENTER - Temp. Loc. Floor 5
    sections.add(
      _buildRackWidget(
        "Temp. Loc. Floor 5\n16", 
        370, 580, 120, 50,
        Colors.pink[300]!
      ),
    );

    // CENTER - Rack Line 4
    sections.add(
      _buildRackWidget(
        "Rack Line 4\n14", 
        370, 640, 120, 50,
        const Color(0xFFFFC107)
      ),
    );

    // CENTER - Temp. Loc. Floor 4
    sections.add(
      _buildRackWidget(
        "Temp. Loc. Floor 4\n489", 
        370, 700, 120, 50,
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

    // RIGHT SIDE - Rack Line 1
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
        20, 423, 60, 25,
        Colors.grey[600]!
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
    List<String> parts = label.split('\n');
    String rackName = parts[0];
    String rackNumber = parts.length > 1 ? parts[1] : '';
    
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
        child: Container(
          padding: EdgeInsets.all(height < 30 ? 1 : 2),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              rackName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                shadows: textColor == Colors.white ? [
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ] : [
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    
    if (isRackLine) {
      return Container(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (height > 40) ...[
              Flexible(
                child: Text(
                  rackName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    shadows: textColor == Colors.white ? [
                      Shadow(
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ] : null,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
            ],
            if (rackNumber.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black.withOpacity(0.2), width: 1),
                ),
                child: Text(
                  rackNumber,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize + 1,
                  ),
                ),
              ),
          ],
        ),
      );
    }
    
    if (isTempLocation || isQuarantine || isLoading) {
      return Container(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                rackName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  shadows: textColor == Colors.white ? [
                    Shadow(
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ] : null,
                ),
                maxLines: height > 80 ? 3 : 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (rackNumber.isNotEmpty && rackNumber != '0') ...[
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: bgColor.withOpacity(0.7), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  rackNumber,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize + 1,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    }
    
    // Default format
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              rackName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                shadows: textColor == Colors.white ? [
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ] : null,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (rackNumber.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              rackNumber,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize + 1,
                shadows: textColor == Colors.white ? [
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ] : null,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getTextColor(Color backgroundColor) {
    double luminance = backgroundColor.computeLuminance();
    
    if (luminance > 0.6) {
      return Colors.black87;
    } else if (luminance > 0.4) {
      return Colors.black87;
    } else {
      return Colors.white;
    }
  }

  double _getFontSize(double width, double height) {
    double minDimension = width < height ? width : height;
    double area = width * height;
    
    if (minDimension < 30) return 7;
    if (minDimension < 50) return 8;
    if (minDimension < 70) return 9;
    if (minDimension < 90) return 10;
    if (minDimension < 120) return 11;
    if (minDimension < 150) return 12;
    
    if (area > 20000) return 14;
    if (area > 15000) return 13;
    
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
              },
              child: const Text("View Details"),
            ),
          ],
        );
      },
    );
  }

  int _getItemCount(String rackName) {
    String cleanRackName = rackName.split('\n')[0];
    
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
