// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';
import 'package:habit_forge/core/helpers/habit_icon_catalog.dart';
import 'package:habit_forge/core/helpers/habit_icon_localization_helper.dart';

/// Single selectable icon tile for habit icon picker.
class IconChoiceTile extends StatelessWidget {
  final HabitIconOption option;
  final bool selected;
  final VoidCallback onTap;
  final double iconBoxSize;
  final double iconRadius;

  /// Creates [IconChoiceTile].
  const IconChoiceTile({
    required this.option,
    required this.selected,
    required this.onTap,
    required this.iconBoxSize,
    required this.iconRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = appL10n(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: localizedHabitIconLabel(
        iconKey: option.key,
        l10n: l10n,
        fallbackLabel: option.label,
      ),
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
