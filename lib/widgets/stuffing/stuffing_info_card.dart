import 'package:flutter/material.dart';

class StuffingInfoCard extends StatelessWidget {
  final List<Map<String, String>> infoList;
  const StuffingInfoCard({Key? key, required this.infoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(fontStyle: FontStyle.italic, color: Color(0xFF9CA3AF), fontSize: 16);
    TextStyle valueStyle = const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF111827), fontSize: 18);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: infoList.map((item) => _infoRow(item['label']!, item['value']!, labelStyle, valueStyle)).toList(),
      ),
    );
  }

  Widget _infoRow(String label, String value, TextStyle labelStyle, TextStyle valueStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text(label, style: labelStyle)),
          Expanded(flex: 3, child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }
}
