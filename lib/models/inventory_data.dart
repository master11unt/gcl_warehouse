class InventoryData {
  static List<List<String>> generateInventoryRows(int count, String type) {
    final shippers = [
      'FUJI PALAPA TEXTILE INDUSTRY, PT',
      'ACRYL TEXTILE MILLS, PT',
      'GIMUDAN INDONESIA, PT',
      'MANE INDONESIA, PT',
      'LK PANTOS INDONESIA, PT',
      'WINTASTAR SHIPPING',
      'INDOFOOD SUKSES MAKMUR, PT',
      'UNILEVER INDONESIA, PT',
    ];
    
    final destinations = [
      'JABEL ALI',
      'JAWAHARLA NEHRU',
      'HO CHI MINH',
      'HAIPHONG',
      'LAEM CHABANG',
      'PORT KELANG',
      'HONG KONG',
      'SINGAPORE',
    ];
    
    final quantities = [
      '22 CARTONS',
      '15 BALES',
      '30 PACKAGES', 
      '18 BOXES',
      '25 CARTONS',
      '12 BALES',
      '40 PACKAGES',
      '20 BOXES',
    ];
    
    final markings = [
      'YUNGSUNG',
      'SAMSUNG',
      'TOYOTA',
      'HONDA',
      'MITSUBISHI',
      'PANASONIC',
      'SONY',
      'LG',
    ];
    
    final descriptions = [
      'POLYESTER',
      'COTTON',
      'TEXTILE',
      'AUTOMOTIVE PARTS',
      'ELECTRONICS',
      'CHEMICALS',
      'MACHINERY',
      'PLASTIC GOODS',
    ];
    
    final statuses = [
      'Deliver To Destination / Received In Warehouse',
      'In Transit',
      'Pending Delivery',
      'Ready for Pickup',
      'Under Inspection',
      'Cleared Customs',
    ];
    
    return List<List<String>>.generate(count, (i) {
      final idx = i + 1;
      final code = 'GTW-2025${(idx + 826122425).toString().padLeft(8, '0')}';
      final dateIn = '2025-09-${(idx % 30 + 1).toString().padLeft(2, '0')} ${(10 + idx % 14).toString().padLeft(2, '0')}:${(idx % 60).toString().padLeft(2, '0')}:00';
      final warehouseMeas = '${(1.0 + (idx % 10)).toStringAsFixed(4)} Cbm';
      final weight = '${(1000 + (idx % 500)).toString()}.${(idx % 10)}';
      final pebNumber = idx % 3 == 0 ? 'PEB${(123456 + idx).toString()}' : '-';
      final pebDate = idx % 3 == 0 ? '2025-09-${(idx % 28 + 1).toString().padLeft(2, '0')}' : '-';
      final npeNumber = idx % 4 == 0 ? 'NPE${(789012 + idx).toString()}' : '-';
      final npeDate = idx % 4 == 0 ? '2025-09-${(idx % 28 + 1).toString().padLeft(2, '0')}' : '-';
      final value = idx % 5 == 0 ? '${(10000 + idx * 100)}' : '-';
      final currency = idx % 5 == 0 ? 'USD' : '-';
      
      return [
        code,
        dateIn,
        shippers[idx % shippers.length],
        destinations[idx % destinations.length],
        quantities[idx % quantities.length],
        markings[idx % markings.length],
        descriptions[idx % descriptions.length],
        warehouseMeas,
        weight,
        pebNumber,
        pebDate,
        npeNumber,
        npeDate,
        value,
        currency,
        statuses[idx % statuses.length],
      ];
    });
  }

  // Data untuk Cargo In
  static List<List<String>> get cargoInTableData {
    return generateInventoryRows(50, 'cargo_in');
  }
  
  // Data untuk Stock Inventory  
  static List<List<String>> get stockInventoryTableData {
    return generateInventoryRows(40, 'stock');
  }
  
  // Data untuk Cargo Out
  static List<List<String>> get cargoOutTableData {
    return generateInventoryRows(35, 'cargo_out');
  }

  // Constants
  static const int pageSize = 20;
  static const int totalPages = 30;
}
