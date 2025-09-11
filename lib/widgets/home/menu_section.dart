import 'package:flutter/material.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({Key? key}) : super(key: key);

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
            children: [
              _menuCard(Icons.note_add, "List Cargo in"),
              _menuCard(Icons.description, "Stock Inventory"),
              _menuCard(Icons.description, "List Cargo Out"),
              _menuCard(Icons.inventory, "Stuffing"),
              _menuCard(Icons.layers, "Rack"),
              _menuCard(Icons.menu_book, "Report"),
              _menuCard(Icons.people, "User"),
            ],
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
                child: Icon(icon, color: Colors.black, size: 36),
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
