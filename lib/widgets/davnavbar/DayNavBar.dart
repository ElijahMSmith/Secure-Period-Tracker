import 'package:flutter/material.dart';
import 'package:yours_app/widgets/IconInkwell.dart';
import 'package:yours_app/widgets/davnavbar/DayButton.dart';

const months = [
  "",
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

class DayNavBar extends StatefulWidget {
  final DateTime currentDate;
  final Function setCurrentDate;

  const DayNavBar(
      {super.key, required this.currentDate, required this.setCurrentDate});

  @override
  State<DayNavBar> createState() => _DayNavBarState();
}

class _DayNavBarState extends State<DayNavBar> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 30),
      Text(
        "${months[widget.currentDate.month]} ${widget.currentDate.year}",
        style: const TextStyle(fontSize: 30),
      ),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconInkwell(
          iconData: Icons.arrow_back_ios_rounded,
          onTap: () {
            widget.setCurrentDate(
                widget.currentDate.subtract(const Duration(days: 1)));
          },
        ),
        for (int i = -2; i <= 2; i++)
          Expanded(
              child: DayButton(
                  date: widget.currentDate.add(Duration(days: i)),
                  isCurrentDate: i == 0,
                  setCurrentDate: widget.setCurrentDate,
                  position: i)),
        IconInkwell(
          iconData: Icons.arrow_forward_ios_rounded,
          onTap: () {
            widget.setCurrentDate(
                widget.currentDate.add(const Duration(days: 1)));
          },
        ),
      ]),
      const SizedBox(height: 10),
    ]);
  }
}
