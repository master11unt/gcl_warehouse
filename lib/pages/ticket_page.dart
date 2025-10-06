import 'package:flutter/material.dart';
import '../widgets/home/custom_drawer.dart';
import '../widgets/ticket/ticket_table.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/stuffing/stuffing_dialog.dart';
import '../models/ticket_data.dart';
import 'ticket_cargo_in_detail_page.dart';
import 'ticket_stuffing_detail_page.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> with TickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  int _cargoInPage = 1;
  late final List<List<String>> _cargoInAllRows;
  int _stuffingPage = 1;
  late final List<List<String>> _stuffingAllRows;
  
  bool _isFilterExpanded = false;

  String _selectedCategory = 'None';
  String _selectedStatus = 'All';
  DateTime? _selectedDate;

  String _selectedCategoryStuffing = 'None';
  String _selectedStatusStuffing = 'All';
  DateTime? _selectedDateStuffing;
  
  // Filter options
  final List<String> _categoryOptions = [
    'None', 'GCL-JAKARTA', 'GCL-BANDUNG', 'GCL-CIKARANG', 
    'OSLINE-JAKARTA', 'OSLINE-BANDUNG', 'BPLINE', 'WINFAST', 'LCL', 'FCL'
  ];
  final List<String> _categoryOptionsStuffing = [
    'None', 'GCL-JAKARTA', 'GCL-BANDUNG', 'GCL-CIKARANG', 
    'OSLINE-JAKARTA', 'OSLINE-BANDUNG', 'BPLINE', 'WINFAST'
  ];
  final List<String> _statusOptions = ['Valid', 'Invalid', 'All'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _cargoInAllRows = TicketData.generateCargoInRows(TicketData.cargoInTotalCount);
    _stuffingAllRows = TicketData.generateStuffingRows(TicketData.stuffingTotalCount);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showCreateTicketDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    
    final _bookingCodeController = TextEditingController(text: 'WHM-20250925152539');
    final _shipperNameController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _destinationController = TextEditingController();
    final _descriptionPrintController = TextEditingController();
    final _quantityController = TextEditingController();
    final _packageTypeController = TextEditingController();
    final _volumeController = TextEditingController();
    final _weightController = TextEditingController();
    final _markingController = TextEditingController();
    final _serviceTypeController = TextEditingController();
    final _containerNumberController = TextEditingController();
    final _containerSizeController = TextEditingController();
    final _sealNumberController = TextEditingController();
    final _vesselController = TextEditingController();
    final _connectingVesselController = TextEditingController();
    final _picOrderTicketController = TextEditingController();
    final _contactNameController = TextEditingController();
    final _contactEmailController = TextEditingController();
    
    String _selectedCargoOwner = 'GAP LOGISTICS';
    DateTime? _estimatedTimeDeparture;
    DateTime? _planCargoInDate;
    
    final List<String> _cargoOwnerOptions = [
      'GAP LOGISTICS',
      'DANLIRIS', 
      'SMAS LOGISTICS',
      'ULTRA PRIMA'
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 20, 16),
                        child: Row(
                          children: [
                            const Text(
                              'Create Ticket',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close, size: 24),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                      
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5E7EB),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Cargo In Ticket',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF374151),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                margin: const EdgeInsets.only(left: 12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE5E7EB),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSpecialFormField(
                                'Booking Code',
                                _bookingCodeController.text,
                                isDropdown: false,
                              ),
                              const SizedBox(height: 16),
                              
                              _buildWhiteDropdownField(
                                'Cargo Owner',
                                _selectedCargoOwner,
                                _cargoOwnerOptions,
                                (value) => setState(() => _selectedCargoOwner = value!),
                              ),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Shipper Name', _shipperNameController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Description of Goods', _descriptionController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Destination City', _destinationController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Description Print (Optional)', _descriptionPrintController, required: false),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Quantity', _quantityController, keyboardType: TextInputType.number),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Package Type', _packageTypeController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Volume', _volumeController, keyboardType: TextInputType.number),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Weight', _weightController, keyboardType: TextInputType.number),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Marking', _markingController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Service Type', _serviceTypeController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Container Number', _containerNumberController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Container Size', _containerSizeController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Seal Number', _sealNumberController),
                              const SizedBox(height: 16),
                              
                              _buildDateTimeField(
                                'Estimated Time Departure',
                                _estimatedTimeDeparture,
                                (date) => setState(() => _estimatedTimeDeparture = date),
                              ),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Vessel', _vesselController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Connecting Vessel', _connectingVesselController),
                              const SizedBox(height: 16),
                              
                              _buildDateTimeField(
                                'Plan Cargo In',
                                _planCargoInDate,
                                (date) => setState(() => _planCargoInDate = date),
                              ),
                              const SizedBox(height: 16),
                              
                              _buildFormField('PIC Order Ticket', _picOrderTicketController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Contact Name', _contactNameController),
                              const SizedBox(height: 16),
                              
                              _buildFormField('Contact Email', _contactEmailController, keyboardType: TextInputType.emailAddress),
                              
                              const SizedBox(height: 32),
                              
                              Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE5E7EB),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Cargo In ticket created successfully!')),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF6B7280),
                                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        elevation: 2,
                                      ),
                                      child: const Text(
                                        'Create',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCreateStuffingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const StuffingDialog();
      },
    ).then((result) {
      if (result != null) {
        print('Stuffing ticket created: $result');
      }
    });
  }
  
  Widget _buildFormField(
    String label,
    TextEditingController controller, {
    bool required = true,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
            ),
            validator: required ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            } : null,
          ),
        ),
      ],
    );
  }
  
  Widget _buildDateTimeField(
    String label,
    DateTime? value,
    ValueChanged<DateTime?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(value ?? DateTime.now()),
              );
              if (time != null) {
                final dateTime = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  time.hour,
                  time.minute,
                );
                onChanged(dateTime);
              }
            }
          },
          child: Container(
            height: 48,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null 
                    ? '${value.day}/${value.month}/${value.year} ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}'
                    : 'Select date and time',
                  style: TextStyle(
                    fontSize: 14,
                    color: value != null ? const Color(0xFF374151) : const Color(0xFF9CA3AF),
                  ),
                ),
                const Icon(Icons.calendar_today, color: Color(0xFF6B7280)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialFormField(
    String label,
    String value, {
    bool isDropdown = false,
    List<String>? options,
    ValueChanged<String?>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: isDropdown 
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF111827),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (options != null && onChanged != null) {
                        _showDropdownMenu(options, value, onChanged);
                      }
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF6B7280),
                      size: 20,
                    ),
                  ),
                ],
              )
            : Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
              ),
        ),
      ],
    );
  }

  void _showDropdownMenu(List<String> options, String currentValue, ValueChanged<String?> onChanged) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Cargo Owner',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...options.map((option) {
                return ListTile(
                  title: Text(option),
                  trailing: currentValue == option 
                    ? const Icon(Icons.check, color: Color(0xFF3B82F6)) 
                    : null,
                  onTap: () {
                    onChanged(option);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWhiteDropdownField(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            fillColor: Colors.white,
            filled: true,
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CommonAppBar(),
      drawer: CustomDrawer(currentPage: "ticket"),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: const [
                  SizedBox(
                    width: 4,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Ticket",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFB0B7C1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                indicatorPadding: EdgeInsets.zero,
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: const Color(0xFFF3F4F6),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                tabs: const [
                  SizedBox(
                    height: 46,
                    child: Center(child: Text("Ticket Cargo In")),
                  ),
                  SizedBox(
                    height: 46,
                    child: Center(child: Text("Ticket Stuffing")),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildTicketCargoInTab(), _buildTicketStuffingTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketCargoInTab() {
    final filteredRows = _getFilteredRows(_cargoInAllRows, isCargoInTab: true);
    final totalItems = filteredRows.length;
    final totalPages = (totalItems + TicketData.cargoInPageSize - 1) ~/ TicketData.cargoInPageSize;
    final page = _cargoInPage.clamp(1, totalPages == 0 ? 1 : totalPages);
    final visibleRows = TicketData.paginateRows(filteredRows, page, TicketData.cargoInPageSize);

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        _buildCombinedSummaryOptionsTable(
          summaryTitle1: "Scheduled\nTicket",
          summaryValue1: "1904",
          summaryTitle2: "Checked-In\nTicket", 
          summaryValue2: "5938",
          showSecondSummary: true,
          tableColumns: const [
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
          tableRows: visibleRows,
          emptyMessage: 'Showing Result',
          currentPage: page,
          totalPages: totalPages,
          totalItems: totalItems,
          pageSize: TicketData.cargoInPageSize,
          onPageChange: (p) => setState(() => _cargoInPage = p.clamp(1, totalPages)),
          onRowTap: (row) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketCargoInDetailPage(
                  ticketData: {
                    'bookingCode': row[0],
                    'planDateIn': row[1],
                    'shipper': row[2],
                    'total': row[3],
                    'destination': row[4],
                    'cargoOwner': row[5],
                    'cargoServiceType': row[6],
                    'status': row[7],
                    'description': '15 BALES 2/32NM ACRYLIC 65% AND WOOL 35% YARN UNDYED',
                    'etd': '2025-01-25',
                    'containerNumber': '-',
                    'containerSize': '-',
                    'vessel': 'WAR HAI 377 V.W004',
                    'connectingVessel': '-',
                    'marking': 'SHINGORA B/NO. NHAVA SHEVA PT. ACHEM MADE IN INDONESIA',
                    'estimatedCargoIn': '2024-01-01 00:00:00',
                    'quantity': '15',
                    'package': 'BALES',
                    'weight': '1530',
                    'volume': '3.14',
                    'requestedBy': 'HERI',
                    'requestDate': '2025-01-22',
                    'rulesReference': 'GTW/SOP/JKT/122331',
                  },
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Rules",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Based On : GTW/SOP/JKT/122331",
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTicketStuffingTab() {
    final filteredRows = _getFilteredRows(_stuffingAllRows, isCargoInTab: false);
    final totalItems = filteredRows.length;
    final totalPages = (totalItems + TicketData.stuffingPageSize - 1) ~/ TicketData.stuffingPageSize;
    final page = _stuffingPage.clamp(1, totalPages == 0 ? 1 : totalPages);
    final visibleRows = TicketData.paginateRows(
      filteredRows,
      page,
      TicketData.stuffingPageSize,
    );

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        _buildCombinedSummaryOptionsTable(
          summaryTitle1: "Stuffing Ticket",
          summaryValue1: "342",
          summaryTitle2: "",
          summaryValue2: "",
          showSecondSummary: false,
          isStuffingTab: true,
          tableColumns: const [
            'Job Number',
            'Stuffing Date',
            'Destination',
            'ETD',
            'Closing Date',
            'Stuffing Owner',
            'Total Container Fill',
          ],
          columnWidths: const [
            160, // Job Number
            160, // Stuffing Date
            160, // Destination
            160, // ETD
            160, // Closing Date
            160, // Stuffing Owner
            160, // Total Container Fill
          ],
          tableRows: visibleRows,
          emptyMessage: 'Showing Result',
          currentPage: page,
          totalPages: totalPages,
          totalItems: totalItems,
          pageSize: TicketData.stuffingPageSize,
          onPageChange: (p) => setState(() => _stuffingPage = p.clamp(1, totalPages)),
          onRowTap: (rowData) {
            final stuffingData = {
              'jobNumber': rowData[0], 
              'stuffingDate': rowData[1], 
              'destination': rowData[2],
             'etd': rowData[3],
              'closingDate': rowData[4], 
              'stuffingOwner': rowData[5],
              'totalContainerFill': rowData[6],
              'containerNumber': 'KOCU5009373 / 24H0102212',
              'containerSize': '40HC',
              'vessel': 'HMM MIRACLE V 009N',
              'agent': 'PORTSHA',
              'requestedBy': 'SITI AISYAH',
              'requestDate': '2025-07-24',
              'rulesReference': 'GTW/SOP/JKT/122331',
            };
            
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketStuffingDetailPage(
                  ticketData: stuffingData,
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Rules",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Based On : GTW/SOP/JKT/122331",
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSummaryItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildCombinedSummaryOptionsTable({
    required String summaryTitle1,
    required String summaryValue1,
    required String summaryTitle2,
    required String summaryValue2,
    required List<String> tableColumns,
    required List<double> columnWidths,
    required List<List<String>> tableRows,
    required String emptyMessage,
    required int currentPage,
    required int totalPages,
    required int totalItems,
    required int pageSize,
    required Function(int) onPageChange,
    required Function(List<String>) onRowTap,
    bool showSecondSummary = true,
    bool isStuffingTab = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Section
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(summaryValue1, summaryTitle1),
              ),
              if (showSecondSummary) ...[
                Container(
                  width: 1,
                  height: 72,
                  color: const Color(0xFFE5E7EB),
                ),
                Expanded(
                  child: _buildSummaryItem(summaryValue2, summaryTitle2),
                ),
              ],
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Options Section
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "Options",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => isStuffingTab ? _showCreateStuffingDialog(context) : _showCreateTicketDialog(context),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF6B7280),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Table Section
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "List",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

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
                    controller: _searchController,
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
                    onChanged: (value) => setState(() => searchQuery = value),
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
                            final bool isCargoInTab = _tabController.index == 0;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDatePicker(
                                  initialDate: isCargoInTab ? _selectedDate : _selectedDateStuffing,
                                  onDateSelected: (DateTime selectedDate) {
                                    setState(() {
                                      if (isCargoInTab) {
                                        _selectedDate = selectedDate;
                                      } else {
                                        _selectedDateStuffing = selectedDate;
                                      }
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
                                    () {
                                      final bool isCargoInTab = _tabController.index == 0;
                                      final DateTime? currentDate = isCargoInTab ? _selectedDate : _selectedDateStuffing;
                                      return currentDate != null
                                          ? '${currentDate.day}/${currentDate.month}/${currentDate.year}'
                                          : 'Select Date';
                                    }(),
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
                          children: () {
                            final bool isCargoInTab = _tabController.index == 0;
                            final List<String> currentCategoryOptions = isCargoInTab ? _categoryOptions : _categoryOptionsStuffing;
                            final String currentSelectedCategory = isCargoInTab ? _selectedCategory : _selectedCategoryStuffing;
                            
                            return currentCategoryOptions.map((category) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: _buildFilterChip(
                                category, 
                                currentSelectedCategory == category,
                                () => setState(() {
                                  if (isCargoInTab) {
                                    _selectedCategory = category;
                                  } else {
                                    _selectedCategoryStuffing = category;
                                  }
                                }),
                              ),
                            )).toList();
                          }(),
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
                              () {
                                final bool isCargoInTab = _tabController.index == 0;
                                return isCargoInTab ? _selectedStatus == status : _selectedStatusStuffing == status;
                              }(),
                              () => setState(() {
                                final bool isCargoInTab = _tabController.index == 0;
                                if (isCargoInTab) {
                                  _selectedStatus = status;
                                } else {
                                  _selectedStatusStuffing = status;
                                }
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
            columns: tableColumns,
            columnWidths: columnWidths,
            rows: tableRows,
            emptyMessage: emptyMessage,
            currentPage: currentPage,
            totalPages: totalPages,
            totalItems: totalItems,
            pageSize: pageSize,
            onPageChange: onPageChange,
            onRowTap: onRowTap,
          ),
        ],
      ),
    );
  }

  List<List<String>> _getFilteredRows(List<List<String>> allRows, {bool isCargoInTab = true}) {
    final String selectedCategory = isCargoInTab ? _selectedCategory : _selectedCategoryStuffing;
    final String selectedStatus = isCargoInTab ? _selectedStatus : _selectedStatusStuffing;
    final DateTime? selectedDate = isCargoInTab ? _selectedDate : _selectedDateStuffing;
    
    return allRows.where((row) {
      bool categoryMatch = true;
      bool statusMatch = true;
      bool dateMatch = true;
      
      if (selectedCategory != 'None') {
        categoryMatch = row.length > 6 && 
            (row[2].toLowerCase().contains(selectedCategory.toLowerCase()) ||
             row[6].toLowerCase().contains(selectedCategory.toLowerCase()));
      }
      
      if (selectedStatus != 'All') {
        statusMatch = row.length > 7 && 
            row[7].toLowerCase().contains(selectedStatus.toLowerCase());
      }
      
      if (selectedDate != null && row.length > 1) {
        try {
          final rowDateParts = row[1].split('-');
          if (rowDateParts.length == 3) {
            final rowDate = DateTime(
              int.parse(rowDateParts[0]),
              int.parse(rowDateParts[1]),
              int.parse(rowDateParts[2]),
            );
            final selectedDateOnly = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day);
            final rowDateOnly = DateTime(rowDate.year, rowDate.month, rowDate.day);
            dateMatch = selectedDateOnly.isAtSameMomentAs(rowDateOnly);
          }
        } catch (e) {
          dateMatch = false;
        }
      }
      
      return categoryMatch && statusMatch && dateMatch;
    }).toList();
  }

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
}

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
            
            // Month/Year navigation
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
            
            // Day headers
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
