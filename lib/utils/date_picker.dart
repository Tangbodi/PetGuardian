import 'package:flutter/material.dart';

enum CalendarType {
  gregorianDate,
  // Add other calendar types if needed
}

class DatePicker extends StatelessWidget {
  final DateTime startDate;
  final double? width;
  final double? height;
  final ScrollController? controller;
  final TextStyle? monthTextStyle;
  final TextStyle? dayTextStyle;
  final TextStyle? dateTextStyle;
  final Color? selectedTextColor;
  final Color? selectionColor;
  final Color? deactivatedColor;
  final DateTime? initialSelectedDate;
  final List<DateTime>? activeDates;
  final List<DateTime>? inactiveDates;
  final int? daysCount;
  final Function(DateTime)? onDateChange;
  final String locale;
  final CalendarType calendarType;

  DatePicker(
    this.startDate, {
    Key? key,
    this.width,
    this.height,
    this.controller,
    this.monthTextStyle,
    this.dayTextStyle,
    this.dateTextStyle,
    this.selectedTextColor,
    this.selectionColor,
    this.deactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount,
    this.onDateChange,
    this.locale = "en_US",
    this.calendarType = CalendarType.gregorianDate,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}
