import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/SplashScreen.dart';
import 'pages/CalendarTab.dart';
import 'pages/SettingsTab.dart';
import 'pages/InsightsTab.dart';

Future<bool> showOnboardingPage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? seenOnboarding = prefs.getBool('onboarded');
  return (seenOnboarding == null || !seenOnboarding);
}

void main() {
  runApp(const YoursApp());
}

class YoursApp extends StatelessWidget {
  const YoursApp({Key? key}) : super(key: key);

  static const String _title = 'yours';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: FutureBuilder<bool>(
          future: showOnboardingPage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // I **KNOW** that this looks stupid af, but you can't use snapshot.data as a conditional for null safety
              if (snapshot.data != false) {
                return Container(color: Colors.green); // go to onboarding page
              }
              return const HomePages(); // TODO goes to home now but make it go to login later
            } else {
              return const SplashScreen();
            }
          }),
    );
  }
}

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _tabIndex = 0;

  static const List<Widget> _tabContent = <Widget>[
    CalendarTab(),
    InsightsTab(),
    SettingsTab(),
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