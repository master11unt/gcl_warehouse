import 'package:flutter/material.dart';
import '../../pages/stuffing_detail_page.dart';

class TodayStuffings extends StatelessWidget {
  const TodayStuffings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today Stuffings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF214098),
              ),
            ),
            SizedBox(height: 12),
            // Unloaded Status Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF404B5C),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "Unloaded",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 8),
            // Scrollable Content
            Container(
              height: 180, // Fixed height for scrolling
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _todayStuffingItem(
                      context,
                      "GCL-10025081101",
                      "LAEM CHABANG",
                    ),
                    SizedBox(height: 8),
                    _todayStuffingItem(
                      context,
                      "GCL-10025081105",
                      "BANGKOK",
                    ),
                    SizedBox(height: 8),
                    _todayStuffingItem(
                      context,
                      "GCL-10025081102",
                      "LAEM CHABANG",
                    ),
                    SizedBox(height: 8),
                    _todayStuffingItem(
                      context,
                      "GCL-10025081103",
                      "SINGAPORE",
                    ),
                    SizedBox(height: 8),
                    _todayStuffingItem(
                      context,
                      "GCL-10025081104",
                      "JAKARTA",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _todayStuffingItem(BuildContext context, String jobNumber, String destination) {
    return GestureDetector(
      onTap: () {
        // Navigate to stuffing detail page with the selected data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StuffingDetailPage(
              stuffingData: {
                'jobNumber': jobNumber,
                'destination': destination,
                'status': 'Unloaded',
                // Add more data as needed
              },
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Job Number",
                  style: TextStyle(
                    color: Color(0xFF8B9396),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  jobNumber,
                  style: TextStyle(
                    color: Color(0xFF232F6A),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Destination",
                  style: TextStyle(
                    color: Color(0xFF8B9396),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  destination,
                  style: TextStyle(
                    color: Color(0xFF214098),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
