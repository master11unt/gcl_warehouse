import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gcl_warehouse/widgets/common/custom_form_fields.dart';

class StuffingDialog extends StatefulWidget {
  const StuffingDialog({Key? key}) : super(key: key);

  @override
  State<StuffingDialog> createState() => _StuffingDialogState();
}

class _StuffingDialogState extends State<StuffingDialog> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _containerNumberController = TextEditingController();
  final _destinationController = TextEditingController();
  final _vesselController = TextEditingController();
  final _agentController = TextEditingController();
  final _stuffingInstructionController = TextEditingController();

  // Dropdown values
  String _selectedStuffingOwner = 'DANLIRIS';
  DateTime? _stuffingDate;
  DateTime? _estimatedTimeDeparture;
  String _selectedContainerSize = '20FT';
  DateTime? _closingDate;

  // Dropdown options
  final List<String> _stuffingOwnerOptions = [
    'GAP LOGISTICS',
    'DANLIRIS',
    'SMAS LOGISTICS',
    'ULTRA PRIMA',
  ];

  final List<String> _containerSizeOptions = ['20FT', '40FT', '40HC', '45FT'];

  // Stuffing Fill Table data
  List<Map<String, String>> _stuffingFillRows = [
    {
      'num': '',
      'bookingNumber': '',
      'shipper': '',
      'description': '',
      'quantity': '0',
      'packages': '',
      'destination': '',
      'marking': '',
      'grossWeight': '',
      'nettWeight': '',
      'shipperMeas': '',
      'warehouseMeas': '',
      'chargedMeas': '',
    },
  ];

  void _addRow() {
    setState(() {
      _stuffingFillRows.add({
        'num': '',
        'bookingNumber': '',
        'shipper': '',
        'description': '',
        'quantity': '0',
        'packages': '',
        'destination': '',
        'marking': '',
        'grossWeight': '',
        'nettWeight': '',
        'shipperMeas': '',
        'warehouseMeas': '',
        'chargedMeas': '',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: SizedBox(
                        width: 14,
                        height: 14,
                        child: SvgPicture.asset(
                          'assets/icons/close.svg',
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF374151),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Stuffing Ticket',
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

              // Form Content
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdownFormField(
                        label: 'Stuffing Owner',
                        value: _selectedStuffingOwner,
                        options: _stuffingOwnerOptions,
                        onChanged: (value) => setState(() {
                          if (value != null) _selectedStuffingOwner = value;
                        }),
                      ),
                      const SizedBox(height: 20),

                      CustomDateTimeFormField(
                        label: 'Stuffing Date',
                        value: _stuffingDate,
                        onChanged: (date) => setState(() => _stuffingDate = date),
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        label: 'Container Number',
                        controller: _containerNumberController,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 20),

                      CustomDateTimeFormField(
                        label: 'Estimated Time Departure',
                        value: _estimatedTimeDeparture,
                        onChanged: (date) => setState(() => _estimatedTimeDeparture = date),
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        label: 'Destination',
                        controller: _destinationController,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 20),

                      CustomDropdownFormField(
                        label: 'Container Size',
                        value: _selectedContainerSize,
                        options: _containerSizeOptions,
                        onChanged: (value) => setState(() {
                          if (value != null) _selectedContainerSize = value;
                        }),
                      ),
                      const SizedBox(height: 20),

                      CustomDateTimeFormField(
                        label: 'Closing Date',
                        value: _closingDate,
                        onChanged: (date) => setState(() => _closingDate = date),
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        label: 'Vessel',
                        controller: _vesselController,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        label: 'Agent',
                        controller: _agentController,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 32),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Stuffing Fill',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildStuffingFillTable(),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: _addRow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6B7280),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'Add Row',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      CustomTextAreaField(
                        label: 'Instruksi Stuffing',
                        controller: _stuffingInstructionController,
                        maxLines: 2,
                      ),

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
                              onPressed: _handleCreate,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6B7280),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
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
  }

  // The form field widgets are now provided by shared custom widgets in
  // lib/widgets/common/custom_form_fields.dart. Previous helper methods were
  // removed to avoid duplicate/unused declarations and keep a single source of truth.

  Widget _buildStuffingFillTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            // Table Header
            Container(
              decoration: const BoxDecoration(color: Color(0xFF6B7280)),
              child: Row(
                children: [
                  _buildTableHeaderCell('Num', 80),
                  _buildTableHeaderCell('Booking Number', 180),
                  _buildTableHeaderCell('Shipper', 150),
                  _buildTableHeaderCell('Description', 200),
                  _buildTableHeaderCell('Quantity', 120),
                  _buildTableHeaderCell('Packages', 120),
                  _buildTableHeaderCell('Destination', 150),
                  _buildTableHeaderCell('Marking', 150),
                  _buildTableHeaderCell('Gross Weight', 130),
                  _buildTableHeaderCell('Nett Weight', 130),
                  _buildTableHeaderCell('Shipper Meas', 130),
                  _buildTableHeaderCell('Warehouse Meas', 140),
                  _buildTableHeaderCell('Charged Meas', 130),
                  _buildTableHeaderIconCell(
                    Icons.settings,
                    80,
                  ), // Ini akan diganti di fungsi _buildTableHeaderIconCell
                ],
              ),
            ),

            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  children:
                      _stuffingFillRows.asMap().entries.map((entry) {
                        final index = entry.key;
                        final row = entry.value;

                        return Row(
                          children: [
                            _buildTableCell(
                              row['num']!,
                              80,
                              onChanged: (value) {
                                setState(
                                  () => _stuffingFillRows[index]['num'] = value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['bookingNumber']!,
                              180,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['bookingNumber'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['shipper']!,
                              150,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['shipper'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['description']!,
                              200,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['description'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['quantity']!,
                              120,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['quantity'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['packages']!,
                              120,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['packages'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['destination']!,
                              150,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['destination'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['marking']!,
                              150,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['marking'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['grossWeight']!,
                              130,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['grossWeight'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['nettWeight']!,
                              130,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['nettWeight'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['shipperMeas']!,
                              130,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['shipperMeas'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['warehouseMeas']!,
                              140,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['warehouseMeas'] =
                                          value,
                                );
                              },
                            ),
                            _buildTableCell(
                              row['chargedMeas']!,
                              130,
                              onChanged: (value) {
                                setState(
                                  () =>
                                      _stuffingFillRows[index]['chargedMeas'] =
                                          value,
                                );
                              },
                            ),
                            _buildActionCell(
                              index,
                            ), // Ini akan menggunakan SVG delete di fungsi _buildActionCell
                          ],
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeaderCell(String text, double width) {
    return Container(
      width: width,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFF9CA3AF), width: 1)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTableHeaderIconCell(IconData icon, double width) {
    return Container(
      width: width,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFF9CA3AF), width: 1)),
      ),
      child: Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: SvgPicture.asset(
            'assets/icons/setting.svg', // Ganti dengan path SVG Anda
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCell(
    String value,
    double width, {
    Function(String)? onChanged,
    bool isReadOnly = false,
  }) {
    return Container(
      width: width,
      height: 48,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
          bottom: BorderSide(color: const Color(0xFFE5E7EB), width: 0.5),
        ),
        color: isReadOnly ? const Color(0xFFF9FAFB) : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child:
            isReadOnly
                ? Center(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                : TextFormField(
                  initialValue: value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF374151),
                  ),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  onChanged: onChanged,
                ),
      ),
    );
  }

  Widget _buildActionCell(int index) {
    return Container(
      width: 80,
      height: 48,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
          bottom: BorderSide(color: const Color(0xFFE5E7EB), width: 0.5),
        ),
        color: Colors.white,
      ),
      child: Center(
        child: IconButton(
          onPressed: () => _removeRow(index),
          icon: SizedBox(
            width: 18,
            height: 18,
            child: SvgPicture.asset(
              'assets/icons/delete.svg', // Ganti dengan path SVG Anda
              colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
            ),
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          tooltip: 'Delete row',
        ),
      ),
    );
  }

  void _removeRow(int index) {
    if (_stuffingFillRows.length > 1) {
      setState(() {
        _stuffingFillRows.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('At least one row is required'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _handleCreate() {
    if (_formKey.currentState!.validate()) {

      final stuffingData = {
        'stuffingOwner': _selectedStuffingOwner,
        'stuffingDate': _stuffingDate,
        'containerNumber': _containerNumberController.text,
        'estimatedTimeDeparture': _estimatedTimeDeparture,
        'destination': _destinationController.text,
        'containerSize': _selectedContainerSize,
        'closingDate': _closingDate,
        'vessel': _vesselController.text,
        'agent': _agentController.text,
        'stuffingFill': _stuffingFillRows,
        'stuffingInstruction': _stuffingInstructionController.text,
      };

      Navigator.pop(context, stuffingData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Stuffing ticket created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _containerNumberController.dispose();
    _destinationController.dispose();
    _vesselController.dispose();
    _agentController.dispose();
    _stuffingInstructionController.dispose();
    super.dispose();
  }
}
