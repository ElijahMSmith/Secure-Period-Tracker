import 'package:flutter/material.dart';
import 'package:yours_app/widgets/journal/Journal.dart';
import 'package:yours_app/widgets/calendar/Calendar.dart';
import 'package:yours_app/widgets/davnavbar/DayNavBar.dart';

class ContentTab extends StatefulWidget {
  const ContentTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentTab> createState() => _ContentTabState();
}

class _ContentTabState extends State<ContentTab> {
  DateTime _currentDate = DateTime.now();

  int _contentIndex = 0;
  static final List<Widget> _content = <Widget>[
    Calendar(),
    Journal.withoutData(currentDate: DateTime.now())
  ];

  void setCurrentDate(DateTime newDate) {
    setState(() => _currentDate = newDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DayNavBar(currentDate: _currentDate, setCurrentDate: setCurrentDate),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: IconButton(
                  onPressed: () => setCurrentDate(DateTime.now()),
                  icon: const Icon(Icons.autorenew),
                  iconSize: 40.0,
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: TextButton.icon(
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: const Color.fromARGB(255, 0, 0, 0)),
                          onPressed: () {
                            debugPrint("Log test");
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                          ),
                          label: const Text(
                            "Log Symptoms",
                            style: TextStyle(fontSize: 18),
                          )))),
              Expanded(
                flex: 2,
                child: IconButton(
                  onPressed: () => setState(() {
                    _contentIndex = (_contentIndex + 1) % 2;
                  }),
                  icon: Icon(
                    _contentIndex == 0 ? Icons.book : Icons.calendar_month,
                  ),
                  iconSize: 40.0,
                ),
              )
            ]),
        const SizedBox(height: 10),
        Expanded(child: _content[_contentIndex])
      ],
    );
  }
}
