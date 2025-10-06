import 'package:flutter/material.dart';
import '../../pages/ticket_stuffing_detail_page.dart';

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
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "Unloaded",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 180,
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketStuffingDetailPage(
              ticketData: {
                'jobNumber': jobNumber,
                'destination': destination,
                'status': 'Unloaded',
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
                    color: Color(0xFF0F172A),
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
