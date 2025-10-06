import 'package:flutter/material.dart';

class StatusItemWidget extends StatelessWidget {
  final String label;
  final String value;
  const StatusItemWidget({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor;
    if (value.toLowerCase() == 'complete') {
      textColor = const Color(0xFF10B981);
    } else if (value.toLowerCase() == 'incomplete') {
      textColor = const Color(0xFFEF4444);
    } else {
      textColor = const Color(0xFF0F172A);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF9CA3AF),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
