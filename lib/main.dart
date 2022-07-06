import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/LoginForm.dart';
import 'pages/OnboardingPage.dart';
import 'pages/SplashScreen.dart';

Future<bool> showOnboardingPage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? seenOnboarding = prefs.getBool('onboarded');
  return (seenOnboarding == null || !seenOnboarding);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

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
            if (snapshot.data as bool) {
              return const OnboardingPage();
            }
            return const LoginPage(isError: false);
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}
