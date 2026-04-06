// ignore_for_file: public_member_api_docs, prefer_match_file_name

import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/habit_icon_catalog.dart';

/// Section title for icon picker.
class IconPickerTitle extends StatelessWidget {
  /// Creates [IconPickerTitle].
  const IconPickerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Icon', style: Theme.of(context).textTheme.labelLarge);
  }
}

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
            (option) => _IconChoiceTile(
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

class _IconChoiceTile extends StatelessWidget {
  final HabitIconOption option;
  final bool selected;
  final VoidCallback onTap;
  final double iconBoxSize;
  final double iconRadius;

  const _IconChoiceTile({
    required this.option,
    required this.selected,
    required this.onTap,
    required this.iconBoxSize,
    required this.iconRadius,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: option.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(iconRadius)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: iconBoxSize,
          height: iconBoxSize,
          decoration: BoxDecoration(
            color: selected
                ? colorScheme.primary.withValues(alpha: 0.14)
                : colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.all(Radius.circular(iconRadius)),
          ),
          child: Icon(
            option.icon,
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
