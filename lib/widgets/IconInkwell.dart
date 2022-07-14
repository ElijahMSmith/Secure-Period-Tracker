import 'package:flutter/material.dart';

class IconInkwell extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final double? iconSize;

  const IconInkwell(
      {Key? key, required this.iconData, this.onTap, this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultIconSize = MediaQuery.of(context).size.width / 15;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(iconData, size: iconSize ?? defaultIconSize)),
          )),
    );
  }
}

enum Direction { left, right }
