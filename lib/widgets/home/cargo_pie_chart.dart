import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/home_data.dart';

class CargoPieChart extends StatefulWidget {
  const CargoPieChart({Key? key}) : super(key: key);

  @override
  State<CargoPieChart> createState() => _CargoPieChartState();
}

class _CargoPieChartState extends State<CargoPieChart> {
  String selectedLabel = "Over";
  double selectedValue = 258;
  int touchedIndex = 1;

  List<PieChartSectionData> _buildPieChartSections() {
    final labels = HomeData.cargoSummary.keys.toList();
    final values = HomeData.cargoSummary.values.toList();
    final colors = HomeData.cargoColors.values.toList();

    return List.generate(labels.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? 65.0 : 60.0;

      return PieChartSectionData(
        color: colors[i],
        value: values[i],
        title: '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  Widget _pieLegend(Color color, String label) {
    final isSelected = selectedLabel == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLabel = label;
          selectedValue = HomeData.cargoSummary[label] ?? 0;
          touchedIndex = HomeData.cargoSummary.keys.toList().indexOf(label);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
                border: isSelected ? Border.all(color: color, width: 2) : null,
              ),
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? color : Color(0xFF232F6A),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "Cargo Quantity Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 220,
                    width: 220,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (
                            FlTouchEvent event,
                            pieTouchResponse,
                          ) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;

                              final labels = HomeData.cargoSummary.keys.toList();
                              if (touchedIndex >= 0 &&
                                  touchedIndex < labels.length) {
                                selectedLabel = labels[touchedIndex];
                                selectedValue = HomeData.cargoSummary[selectedLabel] ?? 0;
                              }
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 60,
                        sections: _buildPieChartSections(),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedLabel,
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: HomeData.cargoColors[selectedLabel],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(width: 6),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF232F6A),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              selectedValue.toStringAsFixed(0),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _pieLegend(Color(0xFF214098), "Match"),
                SizedBox(width: 20),
                _pieLegend(Color(0xFFF43D7E), "Over"),
                SizedBox(width: 20),
                _pieLegend(Color(0xFFFBBF24), "Short"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
