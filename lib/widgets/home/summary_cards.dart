import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgIcon(
              assetPath: 'assets/icons/summary.svg',
              size: 24,
              color: Colors.black87,
            ),
            SizedBox(width: 8),
            Text(
              "Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _summaryCard("Total Cargo", "6146"),
            _summaryCard("Total Ticket Cargo In", "0"),
            _summaryCard("Total Damaged Cargo", "1"),
          ],
        ),
      ],
    );
  }

  Widget _summaryCard(
    String title,
    String value, {
    Color color = Colors.white,
    Color textColor = Colors.black,
  }) {
    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    textColor == Colors.white
                        ? Colors.white
                        : Color(0xFF0F172A),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 12),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    textColor == Colors.white
                        ? Colors.white
                        : Color(0xFF214098),
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
