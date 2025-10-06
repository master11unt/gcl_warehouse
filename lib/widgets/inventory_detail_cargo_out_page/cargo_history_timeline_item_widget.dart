import 'package:flutter/material.dart';

class CargoHistoryTimelineItemWidget extends StatelessWidget {
  final bool isCompleted;
  final bool hasConnector;
  final String title;
  final String time;

  const CargoHistoryTimelineItemWidget({
    Key? key,
    required this.isCompleted,
    required this.hasConnector,
    required this.title,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? const Color(0xFF6B7280) : Colors.white,
                    border: Border.all(
                      color: const Color(0xFF6B7280),
                      width: isCompleted ? 0 : 3,
                    ),
                  ),
                ),
                if (hasConnector)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
