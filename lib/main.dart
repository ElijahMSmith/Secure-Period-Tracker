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
        home: LoadingPage(
          future: () => showOnboardingPage(),
          handleFinished: (Object data) {
            return data as bool
                ? const OnboardingPage()
                : const LoginForm(isError: false);
          },
        ));
  }
}

/*
LoadingPage(
  future: () => showOnboardingPage(),
  handleFinished: (Object data) {
    return const (snapshot.data as bool ? OnboardingPage() : LoginForm(isError: false);
  },
)
*/
