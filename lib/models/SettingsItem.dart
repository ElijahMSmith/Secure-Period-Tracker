import 'package:flutter/material.dart';

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