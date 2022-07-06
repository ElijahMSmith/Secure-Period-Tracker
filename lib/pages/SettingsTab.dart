import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'LoginForm.dart';
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
      children: [
        const SettingsItem(
          settingName: "About",
          pagePath: AboutPage(),
        ),
        const Divider(thickness: 3),
        const SettingsItem(
          settingName: "Canary",
          pagePath: CanaryPage(),
        ),
        const Divider(thickness: 3),
        const SettingsItem(
          settingName: "Disclaimers",
          pagePath: DisclaimersPage(),
        ),
        const Divider(thickness: 3),
        ListTile(
          title: const Text(
            "Logout",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.red,
            semanticLabel: 'Select',
          ),
          onTap: () {
            Hive.close();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage(isError: false)),
              (route) => false,
            );
          },
        ),
        Divider(thickness: 3),
      ],
    );
  }
}
