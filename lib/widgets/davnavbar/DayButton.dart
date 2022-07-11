import 'package:flutter/material.dart';
import 'package:yours_app/widgets/calendar/CalendarTile.dart';
import 'package:yours_app/widgets/calendar/DateUtils.dart';

const colors = [
  Color.fromARGB(255, 0, 0, 0),
  Color.fromARGB(255, 150, 150, 150),
  Color.fromARGB(255, 180, 180, 180)
];

class DayButton extends StatelessWidget {
  final Function setCurrentDate;
  final DateTime date;
  final bool isCurrentDate;
  final int position;

  const DayButton(
      {Key? key,
      required this.date,
      required this.isCurrentDate,
      required this.setCurrentDate,
      required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String abbreviation = Utils.weekdays[date.weekday % 7];
    return Column(children: [
      CalendarTile(
          date: date,
          isCurrentDate: isCurrentDate,
          isHeader: false,
          inDisplayedMonth: true,
          onDateSelected: () {
            debugPrint(date.toString());
            setCurrentDate(date);
          },
          textStyleOverride: TextStyle(
              color: colors[position.abs()],
              fontSize: 20,
              fontWeight: FontWeight.w400),
          backgroundColorOverride: const Color.fromARGB(255, 240, 233, 225)),
      Text(
        abbreviation,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 20),
      )
    ]);
  }
}
