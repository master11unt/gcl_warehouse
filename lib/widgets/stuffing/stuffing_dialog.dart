import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';

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
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: SvgIcon(
                        assetPath: 'assets/icons/close.svg',
                        size: 14,
                        color:
                            Colors.black87,
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

              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFormField2(
                        'Stuffing Owner',
                        child: _buildDropdownField2(
                          _selectedStuffingOwner,
                          _stuffingOwnerOptions,
                          (value) =>
                              setState(() => _selectedStuffingOwner = value!),
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildFormField2(
                        'Stuffing Date',
                        child: _buildDateTimeField2(
                          _stuffingDate,
                          (date) => setState(() => _stuffingDate = date),
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildFormField2(
                        'Container Number',
                        child: _buildTextFormField2(_containerNumberController),
                      ),
                      const SizedBox(height: 20),

                      _buildFormField2(
                        'Estimated Time Departure',
                        child: _buildDateTimeField2(
                          _estimatedTimeDeparture,
                          (date) =>
                              setState(() => _estimatedTimeDeparture = date),
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildFormField2(
                        'Destination',
                        child: _buildTextFormField2(_destinationController),
                      ),
                      const SizedBox(height: 20),

                      _buildFormField2(
                        'Container Size',
                        child: _buildDropdownField2(
                          _selectedContainerSize,
                          _containerSizeOptions,
                          (value) =>
                              setState(() => _selectedContainerSize = value!),
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildFormField2(
                        'Closing Date',
                        child: _buildDateTimeField2(
                          _closingDate,
                          (date) => setState(() => _closingDate = date),
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildFormField2(
                        'Vessel',
                        child: _buildTextFormField2(_vesselController),
                      ),
                      const SizedBox(height: 20),

                      _buildFormField2(
                        'Agent',
                        child: _buildTextFormField2(_agentController),
                      ),
                      const SizedBox(height: 32),

                      _buildFormField2(
                        'Stuffing Fill',
                        child: _buildStuffingFillTable(),
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

                      _buildTextAreaField(
                        'Instruksi Stuffing',
                        _stuffingInstructionController,
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

  Widget _buildFormField2(String label, {required Widget child}) {
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
        child,
      ],
    );
  }

  Widget _buildTextFormField2(TextEditingController controller) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
      ),
    );
  }

  Widget _buildDropdownField2(
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
        items:
            options
                .map(
                  (option) =>
                      DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
        onChanged: onChanged,
        icon: SvgIcon(
          assetPath: 'assets/icons/arrow_down.svg',
          size: 8,
          color: const Color(0xFF6B7280),
        ),
      ),
    );
  }

  Widget _buildDateTimeField2(DateTime? value, Function(DateTime?) onChanged) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(value ?? DateTime.now()),
          );
          if (time != null) {
            onChanged(
              DateTime(date.year, date.month, date.day, time.hour, time.minute),
            );
          }
        }
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value != null
                    ? '${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}/${value.year} ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}'
                    : 'mm/dd/yyyy --:-- --',
                style: TextStyle(
                  color:
                      value != null
                          ? const Color(0xFF374151)
                          : const Color(0xFF9CA3AF),
                  fontSize: 14,
                ),
              ),
              SvgIcon(
                assetPath: 'assets/icons/calendar.svg',
                size: 16,
                color: const Color(0xFF6B7280),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextAreaField(String label, TextEditingController controller) {
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
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: 2,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          ),
        ),
      ],
    );
  }

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
                    'assets/icons/setting.svg',
                    80,
                  ),
                ],
              ),
            ),

            // Table Rows
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
                            _buildActionCell(index),
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

  Widget _buildTableHeaderIconCell(String assetPath, double width) {
    return Container(
      width: width,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFF9CA3AF), width: 1)),
      ),
      child: Center(
        child: SvgIcon(
          assetPath: assetPath,
          size: 16,
          color: Colors.white,
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
          icon: SvgIcon(
            assetPath: 'assets/icons/delete.svg',
            size: 18,
            color: Colors.red,
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
      if (_stuffingDate == null ||
          _estimatedTimeDeparture == null ||
          _closingDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all required date fields'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

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
