import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final Direction direction;
  final VoidCallback? onTap;

  const ArrowButton({Key? key, required this.direction, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: direction == Direction.left
                  ? const Icon(
                      Icons.chevron_left,
                    )
                  : const Icon(Icons.chevron_right),
            ),
          )),
    );
  }
}

enum Direction { left, right }
