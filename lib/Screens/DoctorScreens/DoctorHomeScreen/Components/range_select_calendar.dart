import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/DoctorHome/doctor_home_provider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:table_calendar/table_calendar.dart';

class RangeSelectionCalendar extends StatelessWidget {
  const RangeSelectionCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarProvider = Provider.of<DoctorHomeProvider>(context);

    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      selectedDayPredicate: (day) {
        return (calendarProvider.selectedStartDate != null &&
            calendarProvider.selectedEndDate != null &&
            day.isAfter(calendarProvider.selectedStartDate!.subtract(const Duration(days: 1))) &&
            day.isBefore(calendarProvider.selectedEndDate!.add(const Duration(days: 1))));
      },
      onRangeSelected: (start, end, focusedDay) {
        if (start != null && end != null) {
          calendarProvider.selectDateRange(start, end);
        }
      },
      calendarStyle: const CalendarStyle(
        rangeHighlightColor: themeColor,
        markerDecoration: BoxDecoration(
          color: themeColor
        ),
        rangeStartDecoration: BoxDecoration(
          color: themeColor,
          shape: BoxShape.rectangle,
        ),
        rangeEndDecoration: BoxDecoration(
          color: themeColor,
          shape: BoxShape.rectangle,
        ),
      ),
      rangeSelectionMode: RangeSelectionMode.toggledOn,
    );
  }
}
