import 'package:flutter/material.dart';

class SimpleGestureDetector extends StatefulWidget {
  final Widget child;
  final SimpleSwipeConfig swipeConfig;
  final HitTestBehavior? behavior;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;

  const SimpleGestureDetector({
    Key? key,
    required this.child,
    this.swipeConfig = const SimpleSwipeConfig(),
    this.behavior,
    this.onSwipeLeft,
    this.onSwipeRight,
  }) : super(key: key);

  @override
  State<SimpleGestureDetector> createState() => _SimpleGestureDetectorState();
}

class _SimpleGestureDetectorState extends State<SimpleGestureDetector> {
  Offset? _initialSwipeOffset;
  late Offset _finalSwipeOffset;

  void _onHorizontalDragStart(DragStartDetails details) {
    _initialSwipeOffset = details.globalPosition;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _finalSwipeOffset = details.globalPosition;

    if (widget.swipeConfig.swipeDetectionMoment ==
        SwipeDetectionMoment.onUpdate) {
      if (_initialSwipeOffset != null) {
        final offsetDifference = _initialSwipeOffset!.dx - _finalSwipeOffset.dx;

        if (offsetDifference.abs() > widget.swipeConfig.horizontalThreshold) {
          _initialSwipeOffset = null;
          final isSwipeLeft = offsetDifference > 0;
          if (isSwipeLeft) {
            widget.onSwipeLeft!();
          } else {
            widget.onSwipeRight!();
          }
        }
      }
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (widget.swipeConfig.swipeDetectionMoment ==
        SwipeDetectionMoment.onUpdate) {
      return;
    }

    if (_initialSwipeOffset != null) {
      final offsetDifference = _initialSwipeOffset!.dx - _finalSwipeOffset.dx;

      if (offsetDifference.abs() > widget.swipeConfig.horizontalThreshold) {
        _initialSwipeOffset = null;
        final isSwipeLeft = offsetDifference > 0;
        if (isSwipeLeft) {
          widget.onSwipeLeft!();
        } else {
          widget.onSwipeRight!();
        }
      }
    }
  }

  bool _canSwipeHorizontally() {
    return widget.onSwipeLeft != null || widget.onSwipeRight != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onHorizontalDragStart:
          _canSwipeHorizontally() ? _onHorizontalDragStart : null,
      onHorizontalDragUpdate:
          _canSwipeHorizontally() ? _onHorizontalDragUpdate : null,
      onHorizontalDragEnd:
          _canSwipeHorizontally() ? _onHorizontalDragEnd : null,
      child: widget.child,
    );
  }
}

enum SwipeDetectionMoment { onEnd, onUpdate }

class SimpleSwipeConfig {
  final double horizontalThreshold;
  final SwipeDetectionMoment swipeDetectionMoment;

  const SimpleSwipeConfig({
    this.horizontalThreshold = 50.0,
    this.swipeDetectionMoment = SwipeDetectionMoment.onEnd,
  });
}
