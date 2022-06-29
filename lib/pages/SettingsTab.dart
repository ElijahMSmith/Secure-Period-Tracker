import 'package:flutter/material.dart';
import '../models/SettingsItem.dart';
import 'AboutPage.dart';
import 'CanaryPage.dart';
import 'DisclaimersPage.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
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