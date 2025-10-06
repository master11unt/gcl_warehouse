import 'package:flutter/material.dart';

class CalendarGridWidget extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime? selectedDate;
  final Function(int) onDateTap;

  const CalendarGridWidget({
    Key? key,
    required this.currentMonth,
    required this.selectedDate,
    required this.onDateTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final startOfWeek = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    List<Widget> dayWidgets = [];
    for (int i = 0; i < 42; i++) {
      final date = startOfWeek.add(Duration(days: i));
      final isCurrentMonth = date.month == currentMonth.month;
      final isSelected = selectedDate != null &&
          date.year == selectedDate!.year &&
          date.month == selectedDate!.month &&
          date.day == selectedDate!.day;
      final isToday = date.year == DateTime.now().year &&
          date.month == DateTime.now().month &&
          date.day == DateTime.now().day;
      dayWidgets.add(
        GestureDetector(
          onTap: isCurrentMonth ? () => onDateTap(date.day) : null,
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
