import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/home_data.dart';

class WarehouseStatusBarChart extends StatelessWidget {
  const WarehouseStatusBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Status Cargo Warehouse",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF1F2937),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 6000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          );
                          Widget text;
                          switch (value.toInt()) {
                            case 0:
                              text = Transform.rotate(
                                angle: -0.3,
                                child: Text(HomeData.chartLabels[0], style: style),
                              );
                              break;
                            case 1:
                              text = Transform.rotate(
                                angle: -0.3,
                                child: Text(HomeData.chartLabels[1], style: style),
                              );
                              break;
                            case 2:
                              text = Transform.rotate(
                                angle: -0.3,
                                child: Text(HomeData.chartLabels[2], style: style),
                              );
                              break;
                            case 3:
                              text = Transform.rotate(
                                angle: -0.3,
                                child: Text(HomeData.chartLabels[3], style: style),
                              );
                              break;
                            case 4:
                              text = Transform.rotate(
                                angle: -0.3,
                                child: Text(HomeData.chartLabels[4], style: style),
                              );
                              break;
                            case 5:
                              text = Transform.rotate(
                                angle: -0.3,
                                child: Text(HomeData.chartLabels[5], style: style),
                              );
                              break;
                            default:
                              text = Text('', style: style);
                              break;
                          }
                          return SideTitleWidget(
                            meta: meta,
                            space: 16,
                            child: text,
                          );
                        },
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 2000,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            '${(value.toInt())}',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2000,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Color(0xFFE5E7EB),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: HomeData.warehouseStatusData.map((data) => 
                    BarChartGroupData(
                      x: data['x'],
                      barRods: [
                        BarChartRodData(
                          toY: data['y'].toDouble(),
                          color: data['color'],
                          width: 30,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ],
                    ),
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
