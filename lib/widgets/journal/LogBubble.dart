import 'package:flutter/material.dart';

class LogBubble extends StatelessWidget {
  final Color backgroundColor;
  final String text;

  const LogBubble(
      {Key? key, required this.backgroundColor, this.text = "No Data Yet!"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: backgroundColor,
      ),
      child: Row(children: [
        Expanded(
            child: Text(
          text,
          style: const TextStyle(
              fontSize: 20, fontFamily: "Acme", color: Colors.white),
        )),
        const Icon(Icons.chevron_right)
      ]),
    );
  }
}
