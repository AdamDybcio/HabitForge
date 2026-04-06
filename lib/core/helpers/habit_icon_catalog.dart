// ignore_for_file: prefer_match_file_name
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

/// Catalog of all habit icons supported by the app.
const habitIconCatalog = <HabitIconOption>[
  HabitIconOption(key: 'task_alt', label: 'General', icon: Icons.task_alt),
  HabitIconOption(
    key: 'water_drop',
    label: 'Hydration',
    icon: Icons.water_drop,
  ),
  HabitIconOption(
    key: 'self_improvement',
    label: 'Mindfulness',
    icon: Icons.self_improvement,
  ),
  HabitIconOption(
    key: 'fitness_center',
    label: 'Workout',
    icon: Icons.fitness_center,
  ),
  HabitIconOption(key: 'book', label: 'Reading', icon: Icons.book),
  HabitIconOption(key: 'bedtime', label: 'Sleep', icon: Icons.bedtime),
  HabitIconOption(
    key: 'restaurant',
    label: 'Nutrition',
    icon: Icons.restaurant,
  ),
  HabitIconOption(
    key: 'directions_run',
    label: 'Running',
    icon: Icons.directions_run,
  ),
  HabitIconOption(key: 'music_note', label: 'Music', icon: Icons.music_note),
  HabitIconOption(key: 'school', label: 'Learning', icon: Icons.school),
  HabitIconOption(key: 'savings', label: 'Finance', icon: Icons.savings),
  HabitIconOption(key: 'spa', label: 'Wellness', icon: Icons.spa),
  HabitIconOption(key: 'medication', label: 'Health', icon: Icons.medication),
  HabitIconOption(key: 'brush', label: 'Hygiene', icon: Icons.brush),
  HabitIconOption(key: 'code', label: 'Coding', icon: Icons.code),
  HabitIconOption(key: 'language', label: 'Language', icon: Icons.language),
  HabitIconOption(key: 'pets', label: 'Pet Care', icon: Icons.pets),
  HabitIconOption(
    key: 'local_florist',
    label: 'Nature',
    icon: Icons.local_florist,
  ),
  HabitIconOption(key: 'checkroom', label: 'Style', icon: Icons.checkroom),
  HabitIconOption(
    key: 'flight_takeoff',
    label: 'Travel',
    icon: Icons.flight_takeoff,
  ),
  HabitIconOption(
    key: 'smoke_free',
    label: 'No Smoking',
    icon: Icons.smoke_free,
  ),
];

/// Resolves saved icon key into a Material icon.
IconData habitIconFromKey(String key) {
  for (final option in habitIconCatalog) {
    if (option.key == key) {
      return option.icon;
    }
  }

  return Icons.task_alt;
}

/// Resolves icon key into a visual badge palette.
HabitIconPalette habitIconPaletteFromKey(String key) {
  switch (key) {
    case 'water_drop':
      return const HabitIconPalette(
        background: Color(0xFFDDF0FF),
        foreground: Color(0xFF1663C7),
      );
    case 'self_improvement':
      return const HabitIconPalette(
        background: Color(0xFFE8F7ED),
        foreground: Color(0xFF1B8158),
      );
    case 'fitness_center':
      return const HabitIconPalette(
        background: Color(0xFFFFE9E8),
        foreground: Color(0xFFC73442),
      );
    case 'book':
      return const HabitIconPalette(
        background: Color(0xFFEEEAFE),
        foreground: Color(0xFF6047C9),
      );
    case 'bedtime':
      return const HabitIconPalette(
        background: Color(0xFFE9ECFF),
        foreground: Color(0xFF3C4AC9),
      );
    case 'restaurant':
    case 'medication':
      return const HabitIconPalette(
        background: Color(0xFFFFF0E1),
        foreground: Color(0xFFC36A0B),
      );
    case 'directions_run':
      return const HabitIconPalette(
        background: Color(0xFFFFE9E8),
        foreground: Color(0xFFC73442),
      );
    case 'music_note':
    case 'language':
      return const HabitIconPalette(
        background: Color(0xFFEEEAFE),
        foreground: Color(0xFF6047C9),
      );
    case 'school':
    case 'code':
      return const HabitIconPalette(
        background: Color(0xFFE8F0FF),
        foreground: Color(0xFF2B60B8),
      );
    case 'savings':
      return const HabitIconPalette(
        background: Color(0xFFE7F8EF),
        foreground: Color(0xFF1B8158),
      );
    case 'spa':
    case 'local_florist':
      return const HabitIconPalette(
        background: Color(0xFFE8F7ED),
        foreground: Color(0xFF1B8158),
      );
    case 'brush':
    case 'checkroom':
      return const HabitIconPalette(
        background: Color(0xFFFFECEF),
        foreground: Color(0xFFA52C5D),
      );
    case 'pets':
      return const HabitIconPalette(
        background: Color(0xFFFFF2E7),
        foreground: Color(0xFFB56100),
      );
    case 'flight_takeoff':
      return const HabitIconPalette(
        background: Color(0xFFE7F4FF),
        foreground: Color(0xFF0A5DA8),
      );
    case 'smoke_free':
      return const HabitIconPalette(
        background: Color(0xFFEDEFF2),
        foreground: Color(0xFF495161),
      );
    default:
      return const HabitIconPalette(
        background: Color(0xFFF3F4F5),
        foreground: Color(0xFF0058BE),
      );
  }
}
