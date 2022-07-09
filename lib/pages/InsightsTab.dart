import 'package:flutter/material.dart';

class InsightsTab extends StatefulWidget {
  const InsightsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<InsightsTab> createState() => _InsightsTabState();
}

class _InsightsTabState extends State<InsightsTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Insights',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          // TODO can probably extract this widget and pass color, icon, and text as params
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.shade100,
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.pinkAccent,
          ),
          child: Column(
            children: const [
              Icon(
                Icons.water_drop,
                color: Colors.white,
              ),
              Text(
                style: TextStyle(color: Colors.white),
                'period in x days or day x of period',
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.shade100,
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.orangeAccent,
          ),
          child: Column(
            children: const [
              Icon(
                Icons.auto_awesome_sharp,
                color: Colors.white,
              ),
              Text(
                  style: TextStyle(color: Colors.white),
                  'chance of getting pregnant is high/low'),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlue.shade100,
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.lightBlue,
          ),
          child: Column(
            children: const [
              Icon(
                Icons.help,
                color: Colors.white,
              ),
              Text(
                  style: TextStyle(color: Colors.white),
                  'More insights coming soon...'),
            ],
          ),
        ),
      ],
    );
  }
}
