import 'package:flutter/material.dart';
import 'package:yours_app/models/DataPoint.dart';
import 'package:yours_app/widgets/IconInkwell.dart';
import 'package:yours_app/widgets/calendar/DateUtils.dart';
import 'package:yours_app/widgets/calendar/CalendarTile.dart';
import 'package:yours_app/widgets/calendar/GestureDetector.dart';

class Calendar extends StatefulWidget {
  final DateTime currentDate;
  final void Function(DateTime) setCurrentDate;
  final VoidCallback toggleShowingContent;
  bool _hasDateChanged = true;

  Calendar(
      {Key? key,
      required this.currentDate,
      required this.setCurrentDate,
      required this.toggleShowingContent})
      : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late String _monthDisplay;
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    _monthDisplay = Utils.formatMonth(widget.currentDate);
    _month = DateTime(widget.currentDate.year, widget.currentDate.month);
  }

  Widget get nameAndIconRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconInkwell(
            onTap: previousYear, iconData: Icons.keyboard_double_arrow_left),
        IconInkwell(onTap: previousMonth, iconData: Icons.chevron_left),
        Expanded(
          child: Text(_monthDisplay,
              style: const TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center),
        ),
        IconInkwell(onTap: nextMonth, iconData: Icons.chevron_right),
        IconInkwell(
            onTap: nextYear, iconData: Icons.keyboard_double_arrow_right),
      ],
    );
  }

  Widget get calendarGridView {
    return SimpleGestureDetector(
      onSwipeLeft: nextMonth,
      onSwipeRight: previousMonth,
      swipeConfig: const SimpleSwipeConfig(
        horizontalThreshold: 40.0,
        swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
      ),
      child: Column(children: <Widget>[
        GridView.count(
          childAspectRatio: 1.5,
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 7,
          mainAxisSpacing: 2,
          children: calendarBuilder(),
        ),
      ]),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    DateTime now = DateTime.now();

    DateTime date = Utils.firstDayOfWeek(now);
    for (int i = 0; i < 7; i++) {
      dayWidgets.add(
        CalendarTile(
          date: date,
          isCurrentDate: Utils.isSameDay(widget.currentDate, date),
          isHeader: true,
          inDisplayedMonth: true,
        ),
      );
      date.add(const Duration(days: 1));
    }

    bool monthStarted = false;
    bool monthEnded = false;

    final monthStart = Utils.firstDayOfMonth(_month);
    final monthEnd = Utils.lastDayOfMonth(_month);
    final calendarDays = Utils.daysInRange(
        Utils.firstDayOfWeek(monthStart), Utils.lastDayOfWeek(monthEnd));

    // Temporary counter until we remove dummy points
    int i = 0;

    for (var day in calendarDays) {
      if (day.hour > 0) {
        day = day.toLocal();
        day = day.subtract(Duration(hours: day.hour));
      }

      if (monthStarted && day.day == 01) {
        monthEnded = true;
      }

      if (Utils.isFirstDayOfMonth(day)) {
        monthStarted = true;
      }

      dayWidgets.add(
        CalendarTile(
          dataPoint: dummyPoints[i % 5],
          date: day,
          isCurrentDate: Utils.isSameDay(day, widget.currentDate),
          isHeader: false,
          inDisplayedMonth: monthStarted && !monthEnded,
          onDateSelected: () {
            widget.setCurrentDate(day);
            setNewMonth(day);
            widget.toggleShowingContent();
          },
          outsidePadding: 0.0,
          insidePadding: 5.0,
        ),
      );

      i++;
    }
    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    updateIfDateChanged();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 15),
        nameAndIconRow,
        calendarGridView
      ],
    );
  }

  void updateIfDateChanged() {
    if (widget._hasDateChanged) {
      widget._hasDateChanged = false;
      setNewMonth(widget.currentDate);
    }
  }

  void nextMonth() {
    setNewMonth(Utils.nextMonth(_month));
  }

  void previousMonth() {
    setNewMonth(Utils.previousMonth(_month));
  }

  void nextYear() {
    setNewMonth(Utils.nextYear(_month));
  }

  void previousYear() {
    setNewMonth(Utils.previousYear(_month));
  }

  void setNewMonth(DateTime newMonth) {
    setState(() {
      _month = newMonth;
      _monthDisplay = Utils.formatMonth(_month);
    });
  }
}

// TEMP

DataPoint dummyPoint1 = DataPoint(
    date: DateTime.now(),
    dayOfCycle: 5,
    flow: Level.medium,
    painLevel: 3,
    dischargeColor: dischargeColors[1],
    dischargeConsistency: dischargeConsistencies[1],
    dischargeSmells: true,
    emotions: ["Sad", "Anxious", "Angry"],
    symptoms: ["Bloating", "Abdominal Cramps", "Pelvic Pain"],
    sexualActivity: SexualActivity.unprotectedSex);

DataPoint dummyPoint2 = DataPoint(
    date: DateTime.now(),
    dayOfCycle: 6,
    flow: Level.low,
    painLevel: 5,
    dischargeColor: dischargeColors[2],
    dischargeConsistency: dischargeConsistencies[0],
    dischargeSmells: false,
    symptoms: ["Bloating", "Abdominal Cramps", "Pelvic Pain"],
    sexualActivity: SexualActivity.unprotectedSex);

DataPoint dummyPoint3 = DataPoint(
    date: DateTime.now(),
    dayOfCycle: 7,
    flow: Level.none,
    painLevel: 10,
    dischargeColor: dischargeColors[1],
    dischargeConsistency: dischargeConsistencies[1],
    dischargeSmells: false,
    sexualActivity: SexualActivity.unprotectedSex);

DataPoint dummyPoint4 = DataPoint(
  date: DateTime.now(),
  dayOfCycle: 8,
  flow: Level.high,
  painLevel: 7,
  dischargeColor: dischargeColors[0],
  dischargeConsistency: dischargeConsistencies[0],
  dischargeSmells: true,
);

DataPoint? dummyPoint5;

List<DataPoint?> dummyPoints = [
  dummyPoint1,
  dummyPoint2,
  dummyPoint3,
  dummyPoint4,
  dummyPoint5
];
