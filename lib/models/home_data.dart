import 'package:flutter/material.dart';

class MenuItemData {
  final String label;
  final String icon;
  final String? route;

  MenuItemData({
    required this.label,
    required this.icon,
    this.route,
  });
}

class HomeData {
  // Data Cargo Pie Chart
  static final Map<String, double> cargoSummary = {
    "Match": 5806,
    "Over": 258,
    "Short": 50,
  };

  static final Map<String, Color> cargoColors = {
    "Match": Color(0xFF2346A0),
    "Over": Color(0xFFF43D7E),
    "Short": Color(0xFFF7C32E),
  };

  // Data untuk Warehouse Status Chart
  static final List<Map<String, dynamic>> warehouseStatusData = [
    {'x': 0, 'y': 500, 'color': Color(0xFF2346A0), 'label': 'Received'},
    {'x': 1, 'y': 2500, 'color': Color(0xFFF43D7E), 'label': 'Stuffing'},
    {'x': 2, 'y': 1800, 'color': Color(0xFFF7C32E), 'label': 'Delivered'},
    {'x': 3, 'y': 3200, 'color': Color(0xFF10B981), 'label': 'Exited'},
    {'x': 4, 'y': 100, 'color': Color(0xFF8B5CF6), 'label': 'Coloaded'},
    {'x': 5, 'y': 25, 'color': Color(0xFF6B7280), 'label': 'Canceled'},
  ];

  // Chart axis labels
  static final List<String> chartLabels = ['Received', 'Stuffing', 'Delivered', 'Exited', 'Coloaded', 'Canceled'];

  // Summary statistics
  static const int totalCargoIn = 1912;
  static const int totalStuffing = 764;
  static const int totalCapacity = 15000;
  static const int usedCapacity = 6114;
  
  // Calculated values
  static double get capacityPercentage => (usedCapacity / totalCapacity * 100);
  static double get totalCargo => cargoSummary.values.reduce((a, b) => a + b);
}

class HomeDummyData {
  static List<MenuItemData> menuItems = [
    MenuItemData(label: 'List Cargo\nIn', icon: 'assets/icons/list_cargo_in.svg', route: '/list_cargo_in'),
    MenuItemData(label: 'Stock\nInventory', icon: 'assets/icons/inventory.svg', route: '/inventory'),
    MenuItemData(label: 'List Cargo\nOut', icon: 'assets/icons/list_cargo_out.svg', route: '/list_cargo_out'),
    MenuItemData(label: 'Stuffing', icon: 'assets/icons/stuffing.svg', route: '/stuffing'),
    MenuItemData(label: 'Stuffing', icon: 'assets/icons/stuffing_result.svg', route: '/stuffing_result'),
    MenuItemData(label: 'Rack', icon: 'assets/icons/rack.svg', route: '/rack'),
    MenuItemData(label: 'Report', icon: 'assets/icons/report.svg', route: '/report'),
    MenuItemData(label: 'User', icon: 'assets/icons/user_group.svg', route: '/user'),
  ];
}