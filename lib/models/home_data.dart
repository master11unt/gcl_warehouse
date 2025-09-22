import 'package:flutter/material.dart';

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

  // Data untuk Warehouse Status Chart - Hardcoded values untuk chart
  static final List<Map<String, dynamic>> warehouseStatusData = [
    {'x': 0, 'y': 500, 'color': Color(0xFF2346A0), 'label': 'Received'},
    {'x': 1, 'y': 2500, 'color': Color(0xFFF43D7E), 'label': 'Stuffing'},
    {'x': 2, 'y': 1800, 'color': Color(0xFFF7C32E), 'label': 'Deivered'},
    {'x': 3, 'y': 3200, 'color': Color(0xFF10B981), 'label': 'Exited'},
    {'x': 4, 'y': 100, 'color': Color(0xFF8B5CF6), 'label': 'Coloaded'},
    {'x': 5, 'y': 25, 'color': Color(0xFF6B7280), 'label': 'Canceled'},
  ];

  // Chart axis labels
  static final List<String> chartLabels = ['Received', 'Stuffing', 'Deivered', 'Exited', 'Coloaded', 'Canceled'];

  // Summary statistics
  static const int totalCargoIn = 1912;
  static const int totalStuffing = 764;
  static const int totalCapacity = 15000;
  static const int usedCapacity = 6114;
  
  // Calculated values
  static double get capacityPercentage => (usedCapacity / totalCapacity * 100);
  static double get totalCargo => cargoSummary.values.reduce((a, b) => a + b);
}
