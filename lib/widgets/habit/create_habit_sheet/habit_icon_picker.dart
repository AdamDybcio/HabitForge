// ignore_for_file: public_member_api_docs, prefer_match_file_name

import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/habit_icon_catalog.dart';
import 'package:habit_forge/widgets/habit/create_habit_sheet/components/icon_choice_tile.dart';

/// Icon picker widget for habit creation/editing.
class HabitIconPicker extends StatelessWidget {
  final List<HabitIconOption> options;
  final String selectedIconName;
  final double iconBoxSize;
  final double iconRadius;
  final ValueChanged<String> onSelect;

  /// Creates [HabitIconPicker].
  const HabitIconPicker({
    required this.options,
    required this.selectedIconName,
    required this.iconBoxSize,
    required this.iconRadius,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options
          .map(
            (option) => IconChoiceTile(
              option: option,
              selected: selectedIconName == option.key,
              onTap: () => onSelect(option.key),
              iconBoxSize: iconBoxSize,
              iconRadius: iconRadius,
            ),
          )
          .toList(),
    );
  }
}
