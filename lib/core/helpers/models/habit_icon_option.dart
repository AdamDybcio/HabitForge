import 'package:flutter/material.dart';

/// Definition of a selectable habit icon option.
class HabitIconOption {
  /// Stable icon key saved in persistence.
  final String key;

  /// Human-readable label used in tooltips.
  final String label;

  /// Material icon used in UI.
  final IconData icon;

  /// Creates [HabitIconOption].
  const HabitIconOption({
    required this.key,
    required this.label,
    required this.icon,
  });
}
