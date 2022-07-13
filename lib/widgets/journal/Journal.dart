import 'package:flutter/material.dart';
import 'package:yours_app/models/DataPoint.dart';
import 'package:yours_app/widgets/calendar/Calendar.dart';
import 'package:yours_app/widgets/journal/LogBubble.dart';

class Journal extends StatefulWidget {
  final DateTime currentDate;
  DataPoint? data;

  Journal.withData({Key? key, required this.currentDate, this.data})
      : super(key: key);
  Journal.withoutData({Key? key, required this.currentDate}) : super(key: key);

  void setDataPoint(DataPoint data) {
    this.data = data;
  }

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  String toShortenedString(List<String> list) {
    StringBuffer buffer = StringBuffer();
    int word = 0, len = 0;
    for (; word < list.length; word++) {
      int lengthAdded = (word == 0 ? 0 : 2) + list[word].length;
      if (len + lengthAdded > 22) break;
      if (word != 0) buffer.write(", ");
      buffer.write(list[word]);
      len += list[word].length;
    }
    if (list.length > word) buffer.write(", +${list.length - word}");
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final DataPoint dummy = dummyPoint1;
    final dayOfCycle = dummy.dayOfCycle != null
        ? "Day ${dummy.dayOfCycle} of Period"
        : "No Data For This Date!";
    final emotions = toShortenedString(dummy.emotions ?? []);
    final symptoms = toShortenedString(dummy.symptoms ?? []);
    final sexualActivity = dummy.sexualActivity;

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(height: 10),
      Text(
        dayOfCycle,
        style: const TextStyle(fontSize: 30),
      ),
      const SizedBox(height: 10),
      LogBubble(
        text: emotions,
        backgroundColor: const Color.fromARGB(255, 89, 66, 231),
      ),
      LogBubble(
        text: symptoms,
        backgroundColor: const Color.fromARGB(255, 231, 66, 96),
      ),
      LogBubble(
        text: sexualActivity,
        backgroundColor: const Color.fromARGB(255, 168, 66, 231),
      )
    ]);
  }
}
