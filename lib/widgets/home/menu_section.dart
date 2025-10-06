// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gcl_warehouse/models/home_data.dart';

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
            Icon(Icons.border_all_rounded, color: Colors.black),
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
                child: _menuCard(_getIconData(item.icon), item.label),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _menuCard(IconData icon, String label) {
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
                child: Icon(icon, color: Color(0xFF0F172A), size: 36),
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

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'note_add':
        return Icons.note_add;
      case 'inventory_2':
        return Icons.inventory_2;
      case 'description':
        return Icons.description;
      case 'pallet':
        return Icons.pallet;
      case 'all_inbox':
        return Icons.all_inbox;
      case 'layers':
        return Icons.layers;
      case 'menu_book':
        return Icons.menu_book;
      case 'people':
        return Icons.people;
      default:
        return Icons.help_outline;
    }
  }
}
