import 'package:flutter/material.dart';

class WarehouseLayoutDropdownWidget extends StatelessWidget {
  final List<Widget> accurateWarehouseLayout;
  const WarehouseLayoutDropdownWidget({Key? key, required this.accurateWarehouseLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 750,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 950,
            height: 950,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                ),
                ...accurateWarehouseLayout,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
