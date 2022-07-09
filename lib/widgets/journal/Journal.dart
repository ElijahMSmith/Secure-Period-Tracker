import 'package:flutter/material.dart';
import 'package:yours_app/models/DataPoint.dart';

class Journal extends StatefulWidget {
  DateTime currentDate;
  DataPoint? data;

  Journal.withData({Key? key, required this.currentDate, this.data})
      : super(key: key);
  Journal.withoutData({Key? key, required this.currentDate}) : super(key: key);

  void updateDay(DateTime newDate, DataPoint? newData) {
    currentDate = newDate;
    data = newData;
  }

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Period Day X",
            style: TextStyle(fontSize: 30),
          ),
        ]);
  }
}
