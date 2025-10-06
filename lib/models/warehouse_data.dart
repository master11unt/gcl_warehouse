import 'package:flutter/material.dart';

// Data untuk rackItems dan dropdownData agar bisa diakses dari page/widget
final List<Map<String, dynamic>> warehouseRackItems = [
  {'name': 'Rack Line 1', 'items': '30 Items'},
  {'name': 'Rack Line 2', 'items': '88 Items'},
  {'name': 'Rack Line 3', 'items': '24 Items'},
  {'name': 'Rack Line 4', 'items': '14 Items'},
  {'name': 'Rack Line 5', 'items': '8 Items'},
  {'name': 'Rack Line 6', 'items': '7 Items'},
  {'name': 'Rack Line 7', 'items': '0 Items'},
  {'name': 'Rack Line 8', 'items': '2 Items'},
  {'name': 'Rack Line 9', 'items': '0 Items'},
  {'name': 'Rack Line 10', 'items': '1 Items'},
  {'name': 'Temporary Location Floor 3', 'items': '174 Items'},
  {'name': 'Temporary Location Floor 4', 'items': '489 Items'},
  {'name': 'Temporary Location Floor 5', 'items': '16 Items'},
  {'name': 'Temporary Location Floor 6', 'items': '39 Items'},
  {'name': 'Temporary Location Floor 7', 'items': '0 Items'},
  {'name': 'Temporary Location Floor 10', 'items': '35 Items'},
  {'name': 'Temporary Location Front Floor', 'items': '270 Items'},
  {'name': 'Temporary Location Side Floor A', 'items': '9 Items'},
  {'name': 'Temporary Location Side Floor B', 'items': '32 Items'},
  {'name': 'Quarantine Area', 'items': '35 Items'},
  {'name': 'Not In Rack', 'items': '59 Items'},
];

final List<Map<String, String>> warehouseDropdownData = [
  {
    'gtwCode': 'GTW-20250207052451',
    'company': 'UNIAIR INDOTAMA CARGO, PT',
    'quantity': '2 PALLETS',
    'destination': 'KEELUNG (CHILUNG)'
  },
  {
    'gtwCode': 'GTW-20250211030718',
    'company': 'NARUMI INDONESIA, PT',
    'quantity': '5 PALLETS',
    'destination': 'LOS ANGELES'
  },
  {
    'gtwCode': 'GTW-20250212032324',
    'company': 'NARUMI INDONESIA, PT',
    'quantity': '2 PALLETS',
    'destination': 'SHANGHAI'
  },
  {
    'gtwCode': 'GTW-20250207032804',
    'company': 'NARUMI INDONESIA, PT',
    'quantity': '23 CARTONS',
    'destination': 'HONG KONG'
  },
  {
    'gtwCode': 'GTW-20250210044929',
    'company': 'YAMATO INDONESIA FORWARDING, PT',
    'quantity': '2 PALLETS',
    'destination': 'MANZANILLO'
  },
  {
    'gtwCode': 'GTW-20250213040108',
    'company': 'YAMATO INDONESIA FORWARDING, PT',
    'quantity': '3 PACKAGES',
    'destination': 'LAEM CHABANG'
  },
  {
    'gtwCode': 'GTW-20250212015407',
    'company': 'YAMATO INDONESIA FORWARDING, PT',
    'quantity': '2 PALLETS',
    'destination': 'BANGKOK'
  },
];

class WarehouseData {
  static final Map<String, dynamic> rackData = {
    'Not In Rack': 59,
    'racks': [
      {'id': 'Rack Line 1', 'number': '30', 'color': Color(0xFFFFC107), 'items': 30},
      {'id': 'Rack Line 2', 'number': '88', 'color': Color(0xFFFFC107), 'items': 88},
      {'id': 'Rack Line 3', 'number': '24', 'color': Color(0xFFFFC107), 'items': 24},
      {'id': 'Rack Line 4', 'number': '14', 'color': Color(0xFFFFC107), 'items': 14},
      {'id': 'Rack Line 5', 'number': '8', 'color': Color(0xFFFFC107), 'items': 8},
      {'id': 'Rack Line 6', 'number': '7', 'color': Color(0xFFFFC107), 'items': 7},
      {'id': 'Rack Line 7', 'number': '0', 'color': Color(0xFFFFC107), 'items': 0},
      {'id': 'Rack Line 8', 'number': '2', 'color': Color(0xFFFFC107), 'items': 2},
      {'id': 'Rack Line 9', 'number': '0', 'color': Color(0xFFFFC107), 'items': 0},
      {'id': 'Rack Line 10', 'number': '1', 'color': Color(0xFFFFC107), 'items': 1},
      {'id': 'Temporary Location Floor 3', 'number': '174', 'color': Colors.pink[300], 'items': 174},
      {'id': 'Temporary Location Floor 4', 'number': '489', 'color': Colors.pink[300], 'items': 489},
      {'id': 'Temporary Location Floor 5', 'number': '16', 'color': Colors.pink[300], 'items': 16},
      {'id': 'Temporary Location Floor 6', 'number': '39', 'color': Colors.pink[300], 'items': 39},
      {'id': 'Temporary Location Floor 7', 'number': '0', 'color': Colors.pink[300], 'items': 0},
      {'id': 'Temporary Location Floor 10', 'number': '35', 'color': Colors.pink[300], 'items': 35},
      {'id': 'Temporary Location Front Floor', 'number': '270', 'color': Colors.pink[300], 'items': 270},
      {'id': 'Temporary Location Side Floor A', 'number': '9', 'color': Colors.blue[300], 'items': 9},
      {'id': 'Temporary Location Side Floor B', 'number': '32', 'color': Colors.blue[300], 'items': 32},
      {'id': 'Quarantine Area', 'number': '35', 'color': Colors.green[400], 'items': 35},
      {'id': 'Loading Area', 'number': '0', 'color': Colors.orange[400], 'items': 0},
    ]
  };

  static final List<String> rackLines = [
    'All', 'Rack Line 1', 'Rack Line 2', 'Rack Line 3', 'Rack Line 4', 
    'Rack Line 5', 'Rack Line 6', 'Rack Line 7', 'Rack Line 8', 'Rack Line 9', 'Rack Line 10'
  ];

  static final List<String> tempLocations = [
    'All', 'Temporary Location Floor 3', 'Temporary Location Floor 4', 
    'Temporary Location Floor 5', 'Temporary Location Floor 6', 
    'Temporary Location Floor 10', 'Temporary Location Front Floor',
    'Temporary Location Side Floor A', 'Temporary Location Side Floor B'
  ];

  static final List<Map<String, dynamic>> rackCategories = [
    {
      'title': 'Rack Line 1',
      'count': '10 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'GTW-202503041653',
          'type': 'FLUSEN LOGISTIK INDONESIA, PT',
          'info': '1 PALLETS',
          'destination': 'JAKARTA-PKG'
        }
      ]
    },
    {
      'title': 'Rack Line 2',
      'count': '105 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'GTW-202502050232',
          'type': 'WINDAS SHIPPING INDONESIA, PT',
          'info': '1 PALLETS',
          'destination': 'JAKARTA-PKG'
        }
      ]
    },
    {
      'title': 'Rack Line 3',
      'count': '21 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'GTW-202501001820',
          'type': 'SARANA PUBLIC WAREHOUSE, PT',
          'info': '2 ROLLS',
          'destination': 'JAKARTA-PKG'
        }
      ]
    },
    {
      'title': 'Rack Line 4',
      'count': '15 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'GTW-202502081104',
          'type': 'FIKRI JAYA LOGISTIK JAKARTA, PT',
          'info': '4 PALLETS',
          'destination': 'SURABAYAS'
        }
      ]
    },
    {
      'title': 'Rack Line 5',
      'count': '8 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'GTW-202500021913',
          'type': 'SIM LOGISTIK FORWARDING INDONESIA, PT',
          'info': '3 PACKAGES',
          'destination': 'TOKYO'
        }
      ]
    },
    {
      'title': 'Rack Line 6',
      'count': '7 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'GTW-202502055119',
          'type': 'FORTINY MAKMUR, PT',
          'info': '1 CARTONS',
          'destination': 'COLOMBO'
        }
      ]
    },
    {
      'title': 'Rack Line 7',
      'count': '0 Items',
      'isExpanded': false,
      'bookings': []
    },
    {
      'title': 'Rack Line 8',
      'count': '2 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'GTW-202502099554',
          'type': 'MITSU SHIPBUILDERS',
          'info': '1 PALLETS',
          'destination': 'HONG KONG'
        }
      ]
    },
    {
      'title': 'Rack Line 9',
      'count': '0 Items',
      'isExpanded': false,
      'bookings': []
    },
    {
      'title': 'Rack Line 10',
      'count': '1 Items',
      'isExpanded': false,
      'bookings': []
    },
    {
      'title': 'Temporary Location Floor 3',
      'count': '151 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'GTW-202503041653',
          'type': 'FLUSEN LOGISTIK INDONESIA, PT',
          'info': '25 PALLETS',
          'destination': 'JAKARTA-PKG'
        },
        {
          'code': 'GTW-202502051232',
          'type': 'SARANA PUBLIC WAREHOUSE, PT',
          'info': '50 CARTONS',
          'destination': 'SURABAYA'
        },
        {
          'code': 'GTW-202501081820',
          'type': 'WINDAS SHIPPING INDONESIA, PT',
          'info': '76 PACKAGES',
          'destination': 'BATAM'
        },
      ]
    },
    {
      'title': 'Temporary Location Floor 4',
      'count': '283 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'GTW-202503041653',
          'type': 'MAJOR LOGISTICS INDONESIA, PT',
          'info': '120 PALLETS',
          'destination': 'SINGAPORE'
        },
        {
          'code': 'GTW-202502088104',
          'type': 'FIKRI JAYA LOGISTIK JAKARTA, PT',
          'info': '83 CARTONS',
          'destination': 'MALAYSIA'
        },
        {
          'code': 'GTW-202501021913',
          'type': 'SIM LOGISTIK FORWARDING, PT',
          'info': '80 PACKAGES',
          'destination': 'THAILAND'
        },
      ]
    },
    {
      'title': 'Temporary Location Floor 5',
      'count': '12 Items',
      'isExpanded': false,
      'bookings': []
    },
    {
      'title': 'Temporary Location Floor 6',
      'count': '39 Items',
      'isExpanded': false,
      'bookings': []
    },
    {
      'title': 'Temporary Location Floor 10',
      'count': '35 Items',
      'isExpanded': false,
      'bookings': []
    },
    {
      'title': 'Temporary Location Front Floor',
      'count': '234 Items',
      'isExpanded': false,
      'bookings': []
    },
    {
      'title': 'Temporary Location Side Floor A',
      'count': '9 Items',
      'isExpanded': false,
      'bookings': []
    },
    {
      'title': 'Temporary Location Side Floor B',
      'count': '34 Items',
      'isExpanded': false,
      'bookings': []
    },
    {
      'title': 'Quarantine Area',
      'count': '31 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'QTN-202503041653',
          'type': 'INSPECTION PENDING - CHEMICALS',
          'info': '15 DRUMS',
          'destination': 'PENDING'
        },
        {
          'code': 'QTN-202502088104',
          'type': 'CUSTOMS HOLD - ELECTRONICS',
          'info': '16 BOXES',
          'destination': 'PENDING'
        },
      ]
    },
    {
      'title': 'Not In Rack',
      'count': '37 Items',
      'isExpanded': false,
      'bookings': [
        {
          'code': 'NIR-202503041653',
          'type': 'AWAITING RACK ASSIGNMENT',
          'info': '20 PALLETS',
          'destination': 'TBD'
        },
        {
          'code': 'NIR-202502088104',
          'type': 'OVERFLOW - TEMPORARY STORAGE',
          'info': '17 CARTONS',
          'destination': 'TBD'
        },
      ]
    },
  ];
}
