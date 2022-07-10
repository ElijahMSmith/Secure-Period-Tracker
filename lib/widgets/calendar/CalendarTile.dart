import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:yours_app/models/DataPoint.dart';
import 'package:yours_app/widgets/calendar/DateUtils.dart';

class CalendarTile extends StatelessWidget {
  final DataPoint? dataPoint;
  final DateTime date;
  final DateTime currentDate;
  final String dayOfWeek;
  final bool isHeader;
  final bool inDisplayedMonth;
  final VoidCallback? onDateSelected;

  const CalendarTile(
      {Key? key,
      this.dataPoint,
      required this.date,
      required this.currentDate,
      required this.dayOfWeek,
      required this.isHeader,
      required this.inDisplayedMonth,
      required this.onDateSelected})
      : super(key: key);

  Widget buildDot(Color color) {
    return Container(
        margin: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0),
        width: 5.0,
        height: 5.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color));
  }

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      // Top row, which is day abbreviations
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(dayOfWeek),
        ),
      );
    } else {
      // Actual date tiles
      return InkWell(
        onTap: onDateSelected,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Utils.isSameDay(currentDate, date)
                    ? Colors.yellow
                    : (dataPoint != null && dataPoint!.isFilledOut()
                        ? Colors.orange
                        : Colors.white)),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat("d").format(date),
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      // TODO: If we color the bubble, make this white
                      color:
                          Utils.isSameDay(currentDate, date) || inDisplayedMonth
                              ? Colors.black
                              : Colors.grey),
                ),
                // Dots for the events
                dataPoint != null &&
                        (dataPoint!.hasItemsFromList() ||
                            dataPoint!.isFilledOut())
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            if (dataPoint!.hasEmotions()) buildDot(Colors.blue),
                            if (dataPoint!.hasSymptoms()) buildDot(Colors.red),
                            if (dataPoint!.hasSexualActivities())
                              buildDot(Colors.purple),
                          ])
                    : Container(),
              ],
            ),
          ),
        ),
      );
    }
  }
}
