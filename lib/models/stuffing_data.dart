class StuffingData {
  static Map<String, dynamic> getDummyClearedDetail() {
    return {
      'jobNumber': 'GCL-10025091142',
      'containerNumber': 'SIKU2243145 / 0059574',
      'containerSize': '20FT',
      'stuffingDate': '2025-09-01',
      'etd': '2025-09-04',
      'closingDate': '2025-09-02',
      'destination': 'PORT KELANG',
      'agent': 'ASTSIN',
    };
  }

  static List<Map<String, String>> getDummyClearedTable() {
    return [
      {
        'num': 'A',
        'bookingNumber': 'GTW-20250901113423',
        'shipper': 'OCEAN SKY INDONESIA',
        'marking': 'OCEAN SKY INDONESIA',
        'destination': 'PORT KELANG',
        'cargoReadiness': 'CLEARED',
        'quantity': '10',
        'packages': 'PALLETS',
        'description': 'MARINE EQUIPMENT & SPARE PARTS',
        'grossWeight': '3,540.120',
        'nettWeight': '3,350.000',
        'shipperMeas': '8.2000',
        'warehouseMeas': '7.8000',
        'chargedMeas': '9.8400',
        'pebNumber': 'PEB-MY-09/2025/2456',
      },
    ];
  }
  static Map<String, dynamic> getDummyOngoingDetail() {
    return {
      'jobNumber': 'GCL-10025081107',
      'containerNumber': 'SIKU2243145 / 0059574',
      'containerSize': '20FT',
      'stuffingDate': '2025-08-29',
      'etd': '2025-09-03',
      'closingDate': '2025-08-30',
      'destination': 'SINGAPORE',
      'agent': 'ASTSIN',
    };
  }

  static List<Map<String, String>> getDummyOngoingTable() {
    return [
      {
        'num': 'A',
        'bookingNumber': 'GTW-20250810113423',
        'shipper': 'OCEAN SKY I',
        'marking': 'OCEAN SKY I',
        'destination': 'HONG KONG',
        'cargoReadiness': 'READY',
        'quantity': '8',
        'packages': 'PALLETS',
        'description': 'MARINE EQUIPMENT & SPARE PARTS',
        'grossWeight': '3,240.120',
        'nettWeight': '3,150.000',
        'shipperMeas': '7.8000',
        'warehouseMeas': '7.5000',
        'chargedMeas': '9.1200',
        'pebNumber': 'PEB-HK-08/2025/2456',
      },
    ];
  }
  static List<String> getTableColumns(String filter) {
    switch (filter) {
      case 'all':
        return [
          'Job Number',
          'Stuffing Date',
          'Destination',
          'ETD',
          'Closing Date',
          'Stuffing Owner',
          'Total Container Fill',
        ];
      case 'ongoing':
        return [
          'Job Number',
          'Stuffing Date',
          'Destination',
          'ETD',
          'Closing Date',
          'Total Container Fill',
          'Status',
        ];
      case 'cleared':
        return [
          'Job Number',
          'Stuffing Date',
          'Destination',
          'ETD',
          'Closing Date',
          'Total Container Fill',
          'Status',
        ];
      default:
        return [
          'Job Number',
          'Stuffing Date',
          'Destination',
          'ETD',
          'Closing Date',
          'Stuffing Owner',
          'Total Container Fill',
        ];
    }
  }

  static List<double> getColumnWidths(String filter) {
    switch (filter) {
      case 'all':
        return [150, 150, 150, 100, 150, 150, 150];
      case 'ongoing':
        return [150, 150, 120, 100, 150, 150, 120];
      case 'cleared':
        return [150, 150, 120, 100, 150, 150, 120];
      default:
        return [150, 150, 150, 100, 150, 150, 150];
    }
  }

  static int getCount(String filter) {
    if (filter == 'all') {
      return allStuffingData.length;
    }
    return allStuffingData.where((item) => item['status'] == filter).length;
  }
  static final List<Map<String, dynamic>> allStuffingData = [
    {
      'jobNumber': 'GCL-10025070967',
      'stuffingDate': '2025-07-31T00:00:00Z',
      'destination': 'SHANGHAI',
      'etd': '2025-08-02T00:00:00Z',
      'closingDate': '2025-08-31T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 7,
      'status': 'ticket',
    },
    {
      'jobNumber': 'GCL-10025091142',
      'stuffingDate': '2025-09-01T00:00:00Z',
      'destination': 'PORT KELANG',
      'etd': '2025-09-04T00:00:00Z',
      'closingDate': '2025-09-02T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 7,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025081107',
      'stuffingDate': '2025-08-29T00:00:00Z',
      'destination': 'SINGAPORE',
      'etd': '2025-09-03T00:00:00Z',
      'closingDate': '2025-08-30T00:00:00Z',
      'owner': 'GCL-SURABAYA',
      'totalContainerFill': 0,
      'status': 'ongoing',
    },
    {
      'jobNumber': 'GCL-10025080981',
      'stuffingDate': '2025-07-31T00:00:00Z',
      'destination': 'HONG KONG',
      'etd': '2025-08-02T00:00:00Z',
      'closingDate': '2025-08-30T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 12,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025070972',
      'stuffingDate': '2025-07-30T00:00:00Z',
      'destination': 'PORT KLANG',
      'etd': '2025-08-01T00:00:00Z',
      'closingDate': '2025-08-29T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 3,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025030351',
      'stuffingDate': '2025-03-14T00:00:00Z',
      'destination': 'BANGKOK',
      'etd': '2025-03-16T00:00:00Z',
      'closingDate': '2025-03-31T00:00:00Z',
      'owner': 'GCL-SURABAYA',
      'totalContainerFill': 8,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025030302',
      'stuffingDate': '2025-03-07T00:00:00Z',
      'destination': 'BANGKOK',
      'etd': '2025-03-09T00:00:00Z',
      'closingDate': '2025-03-28T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 6,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025010109',
      'stuffingDate': '2025-01-24T00:00:00Z',
      'destination': 'BANGKOK',
      'etd': '2025-01-26T00:00:00Z',
      'closingDate': '2025-02-15T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 4,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025010022',
      'stuffingDate': '2025-01-07T00:00:00Z',
      'destination': 'BANGKOK',
      'etd': '2025-01-09T00:00:00Z',
      'closingDate': '2025-01-31T00:00:00Z',
      'owner': 'GCL-SURABAYA',
      'totalContainerFill': 9,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025010001',
      'stuffingDate': '2024-12-31T00:00:00Z',
      'destination': 'SINGAPORE',
      'etd': '2025-01-02T00:00:00Z',
      'closingDate': '2025-01-20T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 15,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025070971',
      'stuffingDate': '2025-07-28T00:00:00Z',
      'destination': 'HONG KONG',
      'etd': '2025-07-30T00:00:00Z',
      'closingDate': '2025-08-28T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 11,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025070965',
      'stuffingDate': '2025-07-28T00:00:00Z',
      'destination': 'LAEM CHABANG',
      'etd': '2025-07-30T00:00:00Z',
      'closingDate': '2025-08-27T00:00:00Z',
      'owner': 'GCL-SURABAYA',
      'totalContainerFill': 2,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025070890',
      'stuffingDate': '2025-07-17T00:00:00Z',
      'destination': 'CHITTAGONG',
      'etd': '2025-07-19T00:00:00Z',
      'closingDate': '2025-08-17T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 6,
      'status': 'ongoing',
    },
    {
      'jobNumber': 'GCL-10025070954',
      'stuffingDate': '2025-07-25T00:00:00Z',
      'destination': 'KEELUNG TAIWAN',
      'etd': '2025-07-27T00:00:00Z',
      'closingDate': '2025-08-25T00:00:00Z',
      'owner': 'GCL-SURABAYA',
      'totalContainerFill': 8,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025070984',
      'stuffingDate': '2025-07-30T00:00:00Z',
      'destination': 'PORT KLANG',
      'etd': '2025-08-01T00:00:00Z',
      'closingDate': '2025-08-29T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 10,
      'status': 'ongoing',
    },
    {
      'jobNumber': 'GCL-10025070955',
      'stuffingDate': '2025-07-25T00:00:00Z',
      'destination': 'BANGKOK',
      'etd': '2025-07-27T00:00:00Z',
      'closingDate': '2025-08-25T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 5,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025080983',
      'stuffingDate': '2025-08-01T00:00:00Z',
      'destination': 'SINGAPORE',
      'etd': '2025-08-03T00:00:00Z',
      'closingDate': '2025-09-01T00:00:00Z',
      'owner': 'GCL-SURABAYA',
      'totalContainerFill': 7,
      'status': 'ongoing',
    },
    {
      'jobNumber': 'GCL-10025070956',
      'stuffingDate': '2025-07-25T00:00:00Z',
      'destination': 'HONG KONG',
      'etd': '2025-07-27T00:00:00Z',
      'closingDate': '2025-08-25T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 4,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025070987',
      'stuffingDate': '2025-07-31T00:00:00Z',
      'destination': 'LAEM CHABANG',
      'etd': '2025-08-02T00:00:00Z',
      'closingDate': '2025-08-31T00:00:00Z',
      'owner': 'GCL-SURABAYA',
      'totalContainerFill': 6,
      'status': 'cleared',
    },
    {
      'jobNumber': 'GCL-10025080990',
      'stuffingDate': '2025-08-05T00:00:00Z',
      'destination': 'MANILA',
      'etd': '2025-08-07T00:00:00Z',
      'closingDate': '2025-09-05T00:00:00Z',
      'owner': 'GCL-JAKARTA',
      'totalContainerFill': 8,
      'status': 'ongoing',
    },
    {
      'jobNumber': 'GCL-10025080991',
      'stuffingDate': '2025-08-06T00:00:00Z',
      'destination': 'COLOMBO',
      'etd': '2025-08-08T00:00:00Z',
      'closingDate': '2025-09-06T00:00:00Z',
      'owner': 'GCL-SURABAYA',
      'totalContainerFill': 12,
      'status': 'ongoing',
    },
  ];

  static List<Map<String, dynamic>> getFilteredData(String filter) {
    if (filter == 'all') {
      return allStuffingData;
    }
    return allStuffingData.where((item) => item['status'] == filter).toList();
  }

  static List<Map<String, dynamic>> searchData(String query, String filter) {
    List<Map<String, dynamic>> filteredData = getFilteredData(filter);
    
    if (query.isEmpty) {
      return filteredData;
    }
    
    return filteredData.where((item) {
      return item['jobNumber'].toString().toLowerCase().contains(query.toLowerCase()) ||
             item['destination'].toString().toLowerCase().contains(query.toLowerCase()) ||
             item['owner'].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Pagination helper
  static List<Map<String, dynamic>> paginateData(
    List<Map<String, dynamic>> data,
    int page,
    int itemsPerPage,
  ) {
    final startIndex = (page - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, data.length);
    
    if (startIndex >= data.length) {
      return [];
    }
    
    return data.sublist(startIndex, endIndex);
  }

  static int getTotalPages(int totalItems, int itemsPerPage) {
    return (totalItems / itemsPerPage).ceil();
  }

  static String formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return isoDate;
    }
  }

  static String getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'cleared':
        return '#10B981';
      case 'ongoing':
        return '#F59E0B';
      default:
        return '#6B7280';
    }
  }

  static String getStatusDisplayText(String status) {
    switch (status.toLowerCase()) {
      case 'cleared':
        return 'Cleared';
      case 'ongoing':
        return 'Ongoing';
      default:
        return status;
    }
  }

  static const int itemsPerPage = 20;
  static const int defaultTotalResults = 347;
}
