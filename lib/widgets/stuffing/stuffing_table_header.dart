import 'package:flutter/material.dart';

class StuffingTableHeader extends StatelessWidget {
  final List<String> columns;
  const StuffingTableHeader({Key? key, required this.columns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: columns.map((col) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          color: const Color(0xFF1F2937),
          child: Text(
            col,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      )).toList(),
    );
  }
}
