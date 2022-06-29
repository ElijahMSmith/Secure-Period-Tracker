import 'package:flutter/material.dart';
import 'AddDataForm.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddDataForm(),
            ),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      body: const Center(child: Text('Calendar')),
    );
  }
}