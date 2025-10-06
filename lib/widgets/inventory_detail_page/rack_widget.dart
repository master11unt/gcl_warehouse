import 'package:flutter/material.dart';

class RackWidget extends StatelessWidget {
  final String label;
  final double left;
  final double top;
  final double width;
  final double height;
  final Color color;
  final Widget rackContent;
  final VoidCallback? onTap;
  const RackWidget({
    Key? key,
    required this.label,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.color,
    required this.rackContent,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            child: rackContent,
          ),
        ),
      ),
    );
  }
}
