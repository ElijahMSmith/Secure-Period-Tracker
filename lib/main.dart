import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/ContentTab.dart';
import 'pages/SettingsTab.dart';
import 'pages/InsightsTab.dart';

void main() {
  runApp(const YoursApp());
}

class YoursApp extends StatelessWidget {
  const YoursApp({Key? key}) : super(key: key);

  static const String _title = 'yours';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const HomePages(),
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
    ContentTab(),
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
