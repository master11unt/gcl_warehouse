import 'package:flutter/material.dart';

class OptionsSectionWidget extends StatelessWidget {
  final ScrollController optionsScrollController;
  final double scrollIndicatorPosition;
  final Widget Function(IconData, String, {bool isEnabled}) buildOptionButton;
  const OptionsSectionWidget({
    Key? key,
    required this.optionsScrollController,
    required this.scrollIndicatorPosition,
    required this.buildOptionButton,
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
                left: BorderSide(color: Color(0xFF0F172A), width: 6),
              ),
            ),
            child: const Text(
              'Options',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: optionsScrollController,
            child: Row(
              children: [
                buildOptionButton(Icons.ads_click, 'Action', isEnabled: false),
                const SizedBox(width: 16),
                buildOptionButton(Icons.edit_square, 'Edit', isEnabled: false),
                const SizedBox(width: 16),
                buildOptionButton(Icons.share_outlined, 'Share'),
                const SizedBox(width: 16),
                buildOptionButton(Icons.print_outlined, 'Print'),
                const SizedBox(width: 16),
                buildOptionButton(Icons.headset_mic_rounded, 'Call Support'),
                const SizedBox(width: 16),
                buildOptionButton(Icons.send, 'Send Tallysheet'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 100),
                      left: scrollIndicatorPosition,
                      child: Container(
                        width: 20,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
