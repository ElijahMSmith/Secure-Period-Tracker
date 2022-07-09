import 'package:flutter/material.dart';
import 'package:yours_app/models/DataPoint.dart';
import 'package:yours_app/widgets/calendar/DateUtils.dart';
import 'package:yours_app/widgets/calendar/CalendarTile.dart';

class Calendar extends StatefulWidget {
  final DateTime currentDate;

  const Calendar({Key? key, required this.currentDate}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return CalendarTile(
        dataPoint: dummyDataPoint,
        date: now,
        currentDate: now,
        dayOfWeek: Utils.weekdayFormat(now),
        isHeader: false,
        inCurrentMonth: true,
        onDateSelected: () {});
  }
}

DataPoint dummyDataPoint = DataPoint();
