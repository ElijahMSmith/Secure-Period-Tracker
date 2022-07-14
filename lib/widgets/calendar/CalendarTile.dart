import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:yours_app/models/DataPoint.dart';
import 'package:yours_app/widgets/calendar/DateUtils.dart';

class CalendarTile extends StatelessWidget {
  final DataPoint? dataPoint;
  final DateTime date;
  final bool isCurrentDate;
  final bool isHeader;
  final bool inDisplayedMonth;
  final VoidCallback? onDateSelected;
  final TextStyle? textStyleOverride;
  final Color? backgroundColorOverride;
  final double? outsidePadding;
  final double? insidePadding;

  const CalendarTile(
      {Key? key,
      this.dataPoint,
      required this.date,
      required this.isCurrentDate,
      required this.isHeader,
      this.inDisplayedMonth = true,
      this.onDateSelected,
      this.textStyleOverride,
      this.backgroundColorOverride,
      this.outsidePadding,
      this.insidePadding})
      : super(key: key);

  Widget buildDot(Color color) {
    return Container(
        margin: const EdgeInsets.only(left: 1, right: 1),
        width: 6.0,
        height: 6.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color));
  }

  List<Widget> buildDots(DataPoint dataPoint) {
    final List<Widget> dots = [];
    if (dataPoint.hasEmotions()) dots.add(buildDot(Colors.blue));
    if (dataPoint.hasSymptoms()) dots.add(buildDot(Colors.red));
    if (dataPoint.hasSexualActivities()) dots.add(buildDot(Colors.purple));
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      // Top row, which is day abbreviations
      return InkWell(
        customBorder: const CircleBorder(),
        child: Container(
          alignment: Alignment.center,
          child: Text(Utils.weekdays[date.weekday % 7]),
        ),
      );
    } else {
      // Actual date tiles
      return InkWell(
        onTap: onDateSelected,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(outsidePadding ?? 2.0),
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isCurrentDate
                      ? Border.all(color: Colors.blue, width: 4)
                      : null,
                  color: backgroundColorOverride ??
                      (dataPoint != null && dataPoint!.isFilledOut()
                          ? Colors.orange
                          : Colors.white)),
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.all(insidePadding ?? 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${date.day}",
                        style: textStyleOverride ??
                            TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                // TODO: If we color the bubble, make this white
                                color: dataPoint != null &&
                                        dataPoint!.isFilledOut()
                                    ? (inDisplayedMonth
                                        ? Colors.black
                                        : Colors.white)
                                    : (inDisplayedMonth
                                        ? Colors.black
                                        : Colors.grey)),
                      ),
                      // Dots for the events
                      dataPoint != null && dataPoint!.hasItemsFromList()
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: buildDots(dataPoint!))
                          : Container(),
                    ],
                  ))),
        ),
      );
    }
  }
}
