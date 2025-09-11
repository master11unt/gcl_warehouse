class TicketData {
  // Generate data untuk Cargo In
  static List<List<String>> generateCargoInRows(int count) {
    final shippers = [
      'ACRYL TEXTILE MILLS, PT',
      'GIMUDAN INDONESIA, PT',
      'MANE INDONESIA, PT',
      'LK PANTOS INDONESIA, PT',
      'WINTASTAR SHIPPING',
      'INDOFOOD SUKSES MAKMUR, PT',
      'UNILEVER INDONESIA, PT',
      'COCA COLA AMATIL, PT',
    ];
    
    final destinations = [
      'JAWAHARLA NEHRU',
      'HO CHI MINH',
      'VIETNAM',
      'HAIPHONG', 
      'LAEM CHABANG',
      'PORT KELANG',
      'HONG KONG',
      'SINGAPORE',
    ];
    
    final cargoOwners = [
      'GCL-JAKARTA',
      'GCL-SURABAYA',
      'GCL-MEDAN',
      'GCL-SEMARANG',
    ];
    
    final serviceTypes = ['LCL', 'FCL', 'BULK'];
    final statuses = ['Valid', 'Invalid', 'Pending', 'Valid'];
    
    return List<List<String>>.generate(count, (i) {
      final idx = i + 1;
      final code = 'GTW-2025${(idx + 10000).toString().padLeft(8, '0')}';
      final total = '${5 + (idx % 50)} ${['BALES', 'PACKAGES', 'CARTONS', 'BOXES'][idx % 4]}';
      
      return [
        code,
        '2024-01-01 00:00:00',
        shippers[idx % shippers.length],
        total,
        destinations[idx % destinations.length], 
        cargoOwners[idx % cargoOwners.length],
        serviceTypes[idx % serviceTypes.length],
        statuses[idx % statuses.length],
      ];
    });
  }

  // Generate data untuk Stuffing
  static List<List<String>> generateStuffingRows(int count) {
    final destinations = [
      'SHANGHAI',
      'QINGDAO', 
      'NINGBO',
      'TIANJIN',
      'DALIAN',
      'XIAMEN',
      'SHENZHEN',
      'GUANGZHOU',
    ];
    
    final stuffingOwners = [
      'GCL-JAKARTA',
      'GCL-SURABAYA',
      'GCL-MEDAN',
      'GCL-SEMARANG',
    ];
    
    return List<List<String>>.generate(count, (i) {
      final idx = i + 1;
      final jobNumber = 'GCL-${(10025070000 + idx).toString()}';
      final stuffingDate = '2025-07-${(idx % 28 + 1).toString().padLeft(2, '0')}T00:00:00Z';
      final etd = '2025-08-${(idx % 28 + 1).toString().padLeft(2, '0')}T00:00:00Z';
      final closingDate = '2025-08-${(idx % 28 + 1).toString().padLeft(2, '0')}T00:00:00Z';
      final totalContainer = '${1 + (idx % 15)}';
      
      return [
        jobNumber,
        stuffingDate,
        destinations[idx % destinations.length],
        etd,
        closingDate,
        stuffingOwners[idx % stuffingOwners.length],
        totalContainer,
      ];
    });
  }

  // Utility function untuk pagination
  static List<List<String>> paginateRows(List<List<String>> all, int page, int size) {
    if (all.isEmpty) return const [];
    final start = (page - 1) * size;
    final end = (start + size).clamp(0, all.length);
    if (start >= all.length) return const [];
    return all.sublist(start, end);
  }

  // Constants
  static const int cargoInPageSize = 10;
  static const int stuffingPageSize = 10;
  static const int cargoInTotalCount = 1912;
  static const int stuffingTotalCount = 764;
}
