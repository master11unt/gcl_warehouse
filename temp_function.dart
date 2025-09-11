    import 'package:flutter/material.dart';
    import 'package:fl_chart/fl_chart.dart';
  
  class DetailQuantityCargoWidget extends StatefulWidget {
    @override
    _DetailQuantityCargoWidgetState createState() => _DetailQuantityCargoWidgetState();
  }
  
  class _DetailQuantityCargoWidgetState extends State<DetailQuantityCargoWidget> {
    bool _showCenterContent = false;
    int _hoveredSectionIndex = 0;
  
    Map<String, dynamic> _getSectionData(int index) {
      switch (index) {
        case 0:
          return {'title': 'Match', 'value': '6061', 'icon': Icons.check};
        case 1:
          return {'title': 'Over', 'value': '262', 'icon': Icons.arrow_upward};
        case 2:
          return {'title': 'Short', 'value': '0', 'icon': Icons.arrow_downward};
        default:
          return {'title': 'Match', 'value': '6061', 'icon': Icons.check};
      }
    }
  
    Widget _buildLegendItemDetailed(String label, String value, Color color) {
      return Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  
    @override
    Widget build(BuildContext context) {
      return _buildDetailQuantityCargo();
    }
  
    Widget _buildDetailQuantityCargo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header dengan background dark
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF374151),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Detail Quantity Cargo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Chart dan Legend dalam satu container
        Container(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsive sizing based on screen width
              double chartSize = constraints.maxWidth < 400 ? 140 : 200;
              double centerRadius = constraints.maxWidth < 400 ? 40 : 60;
              double radius = constraints.maxWidth < 400 ? 35 : 50;
              double spacing = constraints.maxWidth < 400 ? 16 : 30;
              
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Pie Chart with interactive touch functionality
                  SizedBox(
                    width: chartSize,
                    height: chartSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                if (pieTouchResponse != null && pieTouchResponse.touchedSection != null) {
                                  setState(() {
                                    _showCenterContent = true;
                                    _hoveredSectionIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  });
                                } else if (event is FlPointerExitEvent) {
                                  setState(() {
                                    _showCenterContent = false;
                                  });
                                }
                              },
                            ),
                            sections: [
                              PieChartSectionData(
                                value: 95.8, // Match 6061
                                color: const Color(0xFF1E3888), // Blue
                                title: '',
                                radius: radius,
                              ),
                              PieChartSectionData(
                                value: 4.1, // Over 262
                                color: const Color(0xFFEC4899), // Pink/Red
                                title: '',
                                radius: radius,
                              ),
                              PieChartSectionData(
                                value: 0.1, // Short 0
                                color: const Color(0xFFFBBF24), // Yellow
                                title: '',
                                radius: radius,
                              ),
                            ],
                            centerSpaceRadius: centerRadius,
                            sectionsSpace: 1,
                          ),
                        ),
                        // Center content - tampilkan data berdasarkan section yang dihover
                        if (_showCenterContent)
                          Builder(
                            builder: (context) {
                              final sectionData = _getSectionData(_hoveredSectionIndex);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1F2937),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      sectionData['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
  border: Border.all(
    color: Colors.white,
    width: 1,
  ),
  borderRadius: BorderRadius.circular(2),
                                          ),
                                          child: Icon(
                                            sectionData['icon'],
                                            color: Colors.white,
                                            size: 8,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          sectionData['value'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),

                  SizedBox(width: spacing),

                  // Legend
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItemDetailed(
                          'Match',
                          '6061',
                          const Color(0xFF1E3888),
                        ),
                        const SizedBox(height: 16),
                        _buildLegendItemDetailed(
                          'Over',
                          '262',
                          const Color(0xFFEC4899),
                        ),
                        const SizedBox(height: 16),
                          _buildLegendItemDetailed(
                            'Short',
                            '0',
                            const Color(0xFFFBBF24),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    }
  }
