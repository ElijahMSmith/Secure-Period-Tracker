import 'package:flutter/material.dart';
import 'package:yours_app/models/DataPoint.dart';
import 'package:yours_app/widgets/journal/LogBubble.dart';

class Journal extends StatefulWidget {
  final DateTime currentDate;
  DataPoint? data;

  Journal.withData({Key? key, required this.currentDate, this.data})
      : super(key: key);
  Journal.withoutData({Key? key, required this.currentDate}) : super(key: key);

  void addDataPoint(DataPoint data) {
    this.data = data;
  }

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Period Day X",
            style: TextStyle(fontSize: 30),
          ),
          LogBubble(
            text: "Anger, Tiredness, +5",
            backgroundColor: Color.fromARGB(255, 89, 66, 231),
          )
        ]);
  }
}
