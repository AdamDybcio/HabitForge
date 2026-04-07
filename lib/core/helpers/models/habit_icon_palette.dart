import 'package:flutter/material.dart';

/// Visual palette assigned to a habit icon key.
class HabitIconPalette {
  /// Background color for icon badge.
  final Color background;

  /// Foreground icon color.
  final Color foreground;

  /// Creates [HabitIconPalette].
  const HabitIconPalette({
    required this.background,
    required this.foreground,
  });
}
