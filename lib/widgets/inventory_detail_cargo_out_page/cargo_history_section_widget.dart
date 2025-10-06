import 'package:flutter/material.dart';
import 'cargo_history_timeline_item_widget.dart';

class CargoHistorySectionWidget extends StatelessWidget {
  const CargoHistorySectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF374151), width: 6),
              ),
            ),
            child: const Text(
              'Cargo History',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF374151),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              CargoHistoryTimelineItemWidget(
                isCompleted: true,
                hasConnector: true,
                title: 'Received in warehouse',
                time: '2025-09-09 13:54:10',
              ),
              CargoHistoryTimelineItemWidget(
                isCompleted: true,
                hasConnector: true,
                title: 'Stuffing',
                time: '2025-09-09 13:56:35',
              ),
              CargoHistoryTimelineItemWidget(
                isCompleted: true,
                hasConnector: false,
                title: 'Deliver to destination',
                time: '2025-09-09 18:42:58',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
