import 'package:flutter/material.dart';

class CombinedStatusCargoSectionWidget extends StatelessWidget {
  final Widget Function(String, String) buildStatusItem;
  final Widget Function(String, String, [String?]) buildPropertyItem;
  const CombinedStatusCargoSectionWidget({
    Key? key,
    required this.buildStatusItem,
    required this.buildPropertyItem,
  }) : super(key: key);

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
              'Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 16),
          buildStatusItem('Cargo Status', 'Exited From\nWarehouse'),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE5E7EB), thickness: 1),
          const SizedBox(height: 5),
          buildStatusItem('Cargo Condition', 'All Good'),
          const SizedBox(height: 5),
          const Divider(color: Color(0xFFE5E7EB), thickness: 1),
          const SizedBox(height: 16),
          buildStatusItem('Documentation Status', 'Incomplete'),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF374151), width: 6),
              ),
            ),
            child: const Text(
              'Cargo Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 16),
          buildPropertyItem('In Charge', 'User'),
          const SizedBox(height: 16),
          buildPropertyItem('Created By', 'User', '2025-09-09 07:43:37'),
          const SizedBox(height: 16),
          buildPropertyItem('Last Updated by', 'User', '2025-09-09 07:43:37'),
        ],
      ),
    );
  }
}
