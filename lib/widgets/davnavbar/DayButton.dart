import 'package:flutter/material.dart';

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
    return MaterialButton(
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
    );
  }
}
