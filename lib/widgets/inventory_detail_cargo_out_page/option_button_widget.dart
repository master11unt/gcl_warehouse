import 'package:flutter/material.dart';

class OptionButtonWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isEnabled;
  const OptionButtonWidget({Key? key, required this.icon, required this.label, this.isEnabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isEnabled ? const Color(0xFF0F172A) : const Color(0xFF9CA3AF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isEnabled ? Colors.white : const Color(0xFFD1D5DB),
            size: 24,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
