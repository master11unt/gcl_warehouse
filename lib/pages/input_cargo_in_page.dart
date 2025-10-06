import 'package:flutter/material.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/home/custom_drawer.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../widgets/ticket/ticket_table.dart';
import '../models/ticket_data.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({
    Key? key,
    this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialDate ?? DateTime.now();
    _selectedDate = widget.initialDate;
  }

  void _onQuickSelect(String option) {
    DateTime selectedDate;
    switch (option) {
      case 'Today':
        selectedDate = DateTime.now();
        break;
      case 'Yesterday':
        selectedDate = DateTime.now().subtract(const Duration(days: 1));
        break;
      case 'Last 7 days':
        selectedDate = DateTime.now().subtract(const Duration(days: 7));
        break;
      case 'Last 30 days':
        selectedDate = DateTime.now().subtract(const Duration(days: 30));
        break;
      case 'This month':
        selectedDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
        break;
      case 'Last month':
        final now = DateTime.now();
        selectedDate = DateTime(now.year, now.month - 1, 1);
        break;
      default:
        selectedDate = DateTime.now();
    }
    setState(() {
      _selectedDate = selectedDate;
      _currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    });
    widget.onDateSelected(selectedDate);
    Navigator.pop(context);
  }

  void _onDateTap(int day) {
    final selectedDate = DateTime(_currentMonth.year, _currentMonth.month, day);
    setState(() {
      _selectedDate = selectedDate;
    });
    widget.onDateSelected(selectedDate);
    Navigator.pop(context);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  List<String> _getMonthName() {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return months;
  }

  @override
  Widget build(BuildContext context) {
    final monthNames = _getMonthName();
    final currentMonthName = monthNames[_currentMonth.month - 1];
    return Dialog(
      backgroundColor: const Color(0xFF2D3748),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: [
                _buildQuickOption('Today'),
                _buildQuickOption('Yesterday'),
                _buildQuickOption('Last 7 days'),
                _buildQuickOption('Last 30 days'),
                _buildQuickOption('This month'),
                _buildQuickOption('Last month'),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF4A5568)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _previousMonth,
                    child: const Icon(Icons.chevron_left, color: Colors.white),
                  ),
                  Text(
                    '$currentMonthName ${_currentMonth.year}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: _nextMonth,
                    child: const Icon(Icons.chevron_right, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('Sun', style: TextStyle(color: Color(0xFF718096), fontSize: 12)),
                Text('Mon', style: TextStyle(color: Color(0xFF718096), fontSize: 12)),
                Text('Tue', style: TextStyle(color: Color(0xFF718096), fontSize: 12)),
                Text('Wed', style: TextStyle(color: Color(0xFF718096), fontSize: 12)),
                Text('Thu', style: TextStyle(color: Color(0xFF718096), fontSize: 12)),
                Text('Fri', style: TextStyle(color: Color(0xFF718096), fontSize: 12)),
                Text('Sat', style: TextStyle(color: Color(0xFF718096), fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            _buildCalendarGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickOption(String text) {
    return GestureDetector(
      onTap: () => _onQuickSelect(text),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF63B3ED),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final startOfWeek = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    List<Widget> dayWidgets = [];
    for (int i = 0; i < 42; i++) {
      final date = startOfWeek.add(Duration(days: i));
      final isCurrentMonth = date.month == _currentMonth.month;
      final isSelected = _selectedDate != null &&
          date.year == _selectedDate!.year &&
          date.month == _selectedDate!.month &&
          date.day == _selectedDate!.day;
      final isToday = date.year == DateTime.now().year &&
          date.month == DateTime.now().month &&
          date.day == DateTime.now().day;
      dayWidgets.add(
        GestureDetector(
          onTap: isCurrentMonth ? () => _onDateTap(date.day) : null,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF63B3ED) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: isCurrentMonth
                      ? (isSelected ? Colors.white : Colors.white)
                      : const Color(0xFF4A5568),
                  fontSize: 14,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      children: dayWidgets,
    );
  }
}

class InputCargoInPage extends StatefulWidget {
  const InputCargoInPage({Key? key}) : super(key: key);

  @override
  State<InputCargoInPage> createState() => _InputCargoInPageState();
}

class _InputCargoInPageState extends State<InputCargoInPage> {
  DateTime? _selectedDate;
  // Category and status options matching ticket cargo in
  final List<String> _categoryOptions = [
    'None', 'GCL-JAKARTA', 'GCL-BANDUNG', 'GCL-CIKARANG', 
    'OSLINE-JAKARTA', 'OSLINE-BANDUNG', 'BPLINE', 'WINFAST', 'LCL', 'FCL'
  ];
  final List<String> _statusOptions = ['Valid', 'Invalid', 'All'];
  String _selectedCategory = 'None';
  String _selectedStatus = 'All';
  bool _isFilterExpanded = false;

  Widget _buildFilterChip(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF374151),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  late final List<List<String>> _allValidCargoInRows;
  int _currentPage = 1;
  static const int _pageSize = TicketData.cargoInPageSize;
  String? qrResult;

  @override
  void initState() {
    super.initState();
    _allValidCargoInRows = TicketData.generateCargoInRows(TicketData.cargoInTotalCount)
      .where((row) => row[7] == 'Valid')
      .toList();
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
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                                    final List<Barcode> barcodes = capture.barcodes;
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
                          ? Text('Hasil Scan: $qrResult', style: const TextStyle(fontSize: 16))
                          : const Text('No result', style: TextStyle(fontSize: 20)),
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
                                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.search, color: Colors.white, size: 28),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                            height: 32,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
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
                            child: const Icon(
                              Icons.tune,
                              color: Color(0xFF6B7280),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: "Search",
                                  hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Color(0xFF6B7280),
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
                                    border: Border.all(color: Color(0xFFE5E7EB)),
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
                                              onDateSelected: (DateTime selectedDate) {
                                                setState(() {
                                                  _selectedDate = selectedDate;
                                                });
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                            const Icon(
                                              Icons.calendar_today,
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
                                      children: _categoryOptions.map((category) => Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: _buildFilterChip(
                                          category,
                                          _selectedCategory == category,
                                          () => setState(() {
                                            _selectedCategory = category;
                                          }),
                                        ),
                                      )).toList(),
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
                                      children: _statusOptions.map((status) => Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: _buildFilterChip(
                                          status,
                                          _selectedStatus == status,
                                          () => setState(() {
                                            _selectedStatus = status;
                                          }),
                                        ),
                                      )).toList(),
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
                          100,  // Total
                          150, // Destination
                          120, // Cargo Owner
                          150, // Cargo Service Type
                          100,  // Status
                        ],
                        rows: visibleRows,
                        emptyMessage: 'Showing Result',
                        currentPage: _currentPage,
                        totalPages: (_allValidCargoInRows.length + _pageSize - 1) ~/ _pageSize,
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
