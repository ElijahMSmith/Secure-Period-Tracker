import 'package:flutter/material.dart';

void main() {
  runApp(const YoursApp());
}

class YoursApp extends StatelessWidget {
  const YoursApp({Key? key}) : super(key: key);

  static const String _title = 'yours';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _tabIndex = 0;

  static const List<Widget> _tabContent = <Widget>[
    CalendarScreen(),
    InsightsScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _tabIndex == 2
          ? AppBar(
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            )
          : null,
      body: Center(
        child: _tabContent.elementAt(_tabIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _tabIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        onTap: _onTabTapped,
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This represents the about page"),
      ),
    );
  }
}

class CanaryPage extends StatelessWidget {
  const CanaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Canary"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This represents the canary page"),
      ),
    );
  }
}

class DisclaimersPage extends StatelessWidget {
  const DisclaimersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disclaimers"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This represents the disclaimers page"),
      ),
    );
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: const [
        SettingsItem(
          settingName: "About",
          pagePath: AboutPage(),
        ),
        Divider(thickness: 3),
        SettingsItem(
          settingName: "Canary",
          pagePath: CanaryPage(),
        ),
        Divider(thickness: 3),
        SettingsItem(
          settingName: "Disclaimers",
          pagePath: DisclaimersPage(),
        ),
        Divider(thickness: 3),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String settingName;
  final Widget pagePath;
  //onclick function;

  const SettingsItem({
    Key? key,
    required this.settingName,
    required this.pagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        settingName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
        semanticLabel: 'Select',
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // TODO this transition sucks. we should make it go left/right instead of in/out
            builder: (_) => pagePath,
          ),
        );
      },
    );
  }
}

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
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
          // TODO can prolly extract this widget and pass color, icon, and text as params
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

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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

class AddDataForm extends StatefulWidget {
  const AddDataForm({Key? key}) : super(key: key);

  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add data point"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text("Placeholder for new event form"),
      ),
    );
  }
}
