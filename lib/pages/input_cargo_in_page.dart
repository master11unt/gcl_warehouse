import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/common/custom_drawer.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../widgets/ticket/ticket_table.dart';
import '../models/ticket_data.dart';
import '../widgets/input_cargo_in_page/custom_date_picker.dart';
import '../widgets/input_cargo_in_page/filter_chip_widget.dart';

class InputCargoInPage extends StatefulWidget {
  const InputCargoInPage({Key? key}) : super(key: key);

  @override
  State<InputCargoInPage> createState() => _InputCargoInPageState();
}

class _InputCargoInPageState extends State<InputCargoInPage> {
  DateTime? _selectedDate;
  final List<String> _categoryOptions = [
    'None',
    'GCL-JAKARTA',
    'GCL-BANDUNG',
    'GCL-CIKARANG',
    'OSLINE-JAKARTA',
    'OSLINE-BANDUNG',
    'BPLINE',
    'WINFAST',
    'LCL',
    'FCL',
  ];
  final List<String> _statusOptions = ['Valid', 'Invalid', 'All'];
  String _selectedCategory = 'None';
  String _selectedStatus = 'All';
  bool _isFilterExpanded = false;

  Widget _buildFilterChip(String text, bool isSelected, VoidCallback onTap) {
    return FilterChipWidget(text: text, isSelected: isSelected, onTap: onTap);
  }

  late final List<List<String>> _allValidCargoInRows;
  int _currentPage = 1;
  static const int _pageSize = TicketData.cargoInPageSize;
  String? qrResult;

  @override
  void initState() {
    super.initState();
    _allValidCargoInRows =
        TicketData.generateCargoInRows(
          TicketData.cargoInTotalCount,
        ).where((row) => row[7] == 'Valid').toList();
  }

  List<List<String>> get visibleRows {
    final start = (_currentPage - 1) * _pageSize;
    final end = (start + _pageSize).clamp(0, _allValidCargoInRows.length);
    if (start >= _allValidCargoInRows.length) return [];
    return _allValidCargoInRows.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 400,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Cargo In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Divider(thickness: 1.2),
                      const SizedBox(height: 16),
                      Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: MobileScanner(
                                  fit: BoxFit.cover,
                                  onDetect: (capture) {
                                    final List<Barcode> barcodes =
                                        capture.barcodes;
                                    if (barcodes.isNotEmpty) {
                                      setState(() {
                                        qrResult = barcodes.first.rawValue;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      qrResult != null
                          ? Text(
                            'Hasil Scan: $qrResult',
                            style: const TextStyle(fontSize: 16),
                          )
                          : const Text(
                            'No result',
                            style: TextStyle(fontSize: 20),
                          ),
                      const SizedBox(height: 32),
                      Container(
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF6B7280),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(11),
                                  bottomRight: Radius.circular(11),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: SvgIcon(
                                    assetPath: 'assets/icons/search.svg',
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 40,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const Text(
                            'Valid Ticket',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isFilterExpanded = !_isFilterExpanded;
                              });
                            },
                            child: SvgIcon(
                              assetPath: 'assets/icons/filter_outline.svg',
                              color: Color(0xFF6B7280),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9CA3AF),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: SvgIcon(
                                      assetPath: 'assets/icons/search.svg',
                                      color: Color(0xFF6B7280),
                                      size: 18,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE5E7EB),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_isFilterExpanded)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Time Filter',
                                  style: TextStyle(
                                    color: Color(0xFF374151),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0F172A),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE5E7EB),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomDatePicker(
                                              initialDate: _selectedDate,
                                              onDateSelected: (
                                                DateTime selectedDate,
                                              ) {
                                                setState(() {
                                                  _selectedDate = selectedDate;
                                                });
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _selectedDate != null
                                                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                                    : 'Select Date',
                                                style: const TextStyle(
                                                  color: Color(0xFF6B7280),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const SvgIcon(
                                              assetPath:
                                                  'assets/icons/calendar.svg',
                                              color: Color(0xFF6B7280),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Category Filter',
                                  style: TextStyle(
                                    color: Color(0xFF374151),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 50,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children:
                                          _categoryOptions
                                              .map(
                                                (category) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 8,
                                                      ),
                                                  child: _buildFilterChip(
                                                    category,
                                                    _selectedCategory ==
                                                        category,
                                                    () => setState(() {
                                                      _selectedCategory =
                                                          category;
                                                    }),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Status Filter',
                                  style: TextStyle(
                                    color: Color(0xFF374151),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 50,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children:
                                          _statusOptions
                                              .map(
                                                (status) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 8,
                                                      ),
                                                  child: _buildFilterChip(
                                                    status,
                                                    _selectedStatus == status,
                                                    () => setState(() {
                                                      _selectedStatus = status;
                                                    }),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      TicketTable(
                        columns: const [
                          'Booking Code',
                          'Plan Date In',
                          'Shipper',
                          'Total',
                          'Destination',
                          'Cargo Owner',
                          'Cargo Service Type',
                          'Status',
                        ],
                        columnWidths: const [
                          160, // Booking Code
                          150, // Plan Date In
                          140, // Shipper
                          100, // Total
                          150, // Destination
                          120, // Cargo Owner
                          150, // Cargo Service Type
                          100, // Status
                        ],
                        rows: visibleRows,
                        emptyMessage: 'Showing Result',
                        currentPage: _currentPage,
                        totalPages:
                            (_allValidCargoInRows.length + _pageSize - 1) ~/
                            _pageSize,
                        totalItems: _allValidCargoInRows.length,
                        pageSize: _pageSize,
                        onPageChange: (p) => setState(() => _currentPage = p),
                        onRowTap: (rowData) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
