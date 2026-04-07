// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Animated wrapper for habit list entries.
class AnimatedHabitListEntry extends StatelessWidget {
  final Animation<double> animation;
  final double gap;
  final Widget child;

  /// Creates [AnimatedHabitListEntry].
  const AnimatedHabitListEntry({
    required this.animation,
    required this.gap,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        axisAlignment: -1,
        child: SlideTransition(
          position: slide,
          child: Padding(
            padding: EdgeInsets.only(bottom: gap),
            child: child,
          ),
        ),
      ),
    );
  }
}
