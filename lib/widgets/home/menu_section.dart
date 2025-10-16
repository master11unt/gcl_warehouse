// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gcl_warehouse/models/home_data.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';

class MenuSection extends StatelessWidget {
  final Function(String route)? onMenuTap;

  const MenuSection({
    Key? key,
    this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
           SvgIcon(
              assetPath: 'assets/icons/menu.svg',
              color: Colors.black,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              "Menu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: HomeDummyData.menuItems.map((item) {
              return GestureDetector(
                onTap: () {
                  if (onMenuTap != null && item.route != null) {
                    onMenuTap!(item.route!);
                  }
                },
                child: _menuCard(item.icon, item.label),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _menuCard(String svgPath, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          SizedBox(
            width: 80,
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SvgIcon(
                  assetPath: svgPath,
                  size: 36,
                  color: Color(0xFF0F172A), 
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}