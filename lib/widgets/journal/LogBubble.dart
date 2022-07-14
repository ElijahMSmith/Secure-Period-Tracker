import 'package:flutter/material.dart';

class LogBubble extends StatelessWidget {
  final Color backgroundColor;
  late String text;

  LogBubble({Key? key, this.backgroundColor = Colors.black, String? text})
      : super(key: key) {
    this.text = text ?? "No Data Yet!";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        child: InkWell(
            onTap: () => debugPrint("Test"),
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            splashColor: Colors.green,
            highlightColor: const Color.fromARGB(255, 61, 124, 88),
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                Expanded(
                    child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 20, fontFamily: "Alike", color: Colors.white),
                  maxLines: 1,
                )),
                const Icon(
                  Icons.chevron_right,
                  size: 30,
                  color: Colors.white,
                )
              ]),
            )));
  }
}
