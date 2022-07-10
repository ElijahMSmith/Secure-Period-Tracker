import 'package:flutter/material.dart';
import 'package:yours_app/widgets/calendar/DateUtils.dart';

const colors = [
  Color.fromARGB(255, 0, 0, 0),
  Color.fromARGB(255, 150, 150, 150),
  Color.fromARGB(255, 180, 180, 180)
];

class DayButton extends StatelessWidget {
  final Function setCurrentDate;
  final DateTime date;
  final int position;

  const DayButton(
      {Key? key,
      required this.date,
      required this.setCurrentDate,
      required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String abbreviation = Utils.weekdays[date.weekday % 7];
    return Column(children: [
      MaterialButton(
        color: const Color.fromARGB(255, 240, 233, 225),
        shape: const CircleBorder(),
        onPressed: () {
          debugPrint(date.toString());
          setCurrentDate(date);
        },
        child: Text(
          '${date.day}',
          style: TextStyle(color: colors[position.abs()], fontSize: 20),
        ),
      ),
      Text(
        abbreviation,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 20),
      )
    ]);
  }
}
