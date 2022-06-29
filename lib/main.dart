import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/HomePages.dart';
import 'pages/OnboardingPage.dart';
import 'pages/SplashScreen.dart';

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
                return const OnboardingPage(); // go to onboarding page
              }
              return const HomePages(); // TODO goes to home now but make it go to login later
            } else {
              return const SplashScreen();
            }
          }),
    );
  }
}