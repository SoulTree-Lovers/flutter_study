import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../const/color.dart';

class Calendar extends StatelessWidget {
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;
  final bool Function(DateTime day) selectedDayPredicate;

  const Calendar({
    super.key,
    required this.focusedDay,
    required this.onDaySelected,
    required this.selectedDayPredicate,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBoxDecoration = BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(
        10,
      ),
      border: Border.all(
        color: Colors.grey,
        width: 1,
      ),
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey[700],
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );

    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1900),
      lastDay: DateTime(2100),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: defaultBoxDecoration.copyWith(
          color: primaryColor,
        ),
        defaultDecoration: defaultBoxDecoration,
        weekendDecoration: defaultBoxDecoration.copyWith(
          border: Border.all(
            color: Colors.red[200]!,
            width: 1,
          ),
        ),
        selectedDecoration: defaultBoxDecoration.copyWith(
            border: Border.all(
          color: primaryColor,
          width: 2,
        )),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: primaryColor,
        ),
        outsideDecoration: defaultBoxDecoration.copyWith(
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        outsideTextStyle: defaultTextStyle.copyWith(
          color: Colors.grey,
        ),
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: selectedDayPredicate,
    );
  }
}
