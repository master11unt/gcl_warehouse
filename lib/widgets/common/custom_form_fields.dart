import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool required;
  final int maxLines;
  final TextInputType keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.required = true,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: maxLines == 1 ? keyboardType : TextInputType.multiline,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFF3B82F6)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: true,
            fillColor: Colors.white,
          ),
          style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          validator: required
              ? (value) {
                  if (value == null || value.isEmpty) return 'This field is required';
                  return null;
                }
              : null,
        ),
      ],
    );
  }
}

class CustomTextAreaField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool required;
  final int maxLines;

  const CustomTextAreaField({
    Key? key,
    required this.label,
    required this.controller,
    this.required = true,
    this.maxLines = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: label,
      controller: controller,
      required: required,
      maxLines: maxLines,
    );
  }
}

class CustomDropdownFormField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final bool required;

  const CustomDropdownFormField({
    Key? key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.required = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFF3B82F6)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: true,
            fillColor: Colors.white,
          ),
          style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
          onChanged: onChanged,
          validator: required
              ? (val) {
                  if (val == null || val.isEmpty) return 'This field is required';
                  return null;
                }
              : null,
          icon: SizedBox(
            width: 14,
            height: 14,
            child: SvgPicture.asset(
              'assets/icons/arrow_down.svg',
              colorFilter: const ColorFilter.mode(Color(0xFF6B7280), BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDateTimeFormField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final bool required;

  const CustomDateTimeFormField({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.required = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        FormField<DateTime?>(
          initialValue: value,
          validator: (val) {
            if (required && val == null) return 'This field is required';
            return null;
          },
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
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
                        final d = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                        onChanged(d);
                        state.didChange(d);
                      }
                    }
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: state.hasError ? Colors.red : const Color(0xFFE5E7EB)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value != null
                              ? '${value!.day}/${value!.month}/${value!.year} ${value!.hour.toString().padLeft(2, '0')}:${value!.minute.toString().padLeft(2, '0')}'
                              : 'Select date and time',
                          style: TextStyle(
                            fontSize: 14,
                            color: value != null ? const Color(0xFF374151) : const Color(0xFF9CA3AF),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            colorFilter: const ColorFilter.mode(Color(0xFF6B7280), BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
