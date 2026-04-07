import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';
import 'package:habit_forge/core/helpers/habit_icon_catalog.dart';
import 'package:habit_forge/core/theme/colors.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/habit/components/animated_completion_toggle_button.dart';
import 'package:habit_forge/widgets/habit/components/animated_streak_badge.dart';

/// Single row representation of a habit in a list.
class HabitListItem extends StatelessWidget {
  static const _cardRadius = 24.0;
  static const _badgeRadius = 14.0;
  static const _iconBadgeSize = 40.0;

  /// Habit displayed by this tile.
  final Habit habit;

  /// Callback used to toggle today's completion state.
  final VoidCallback onToggle;

  /// Callback used to start editing this habit.
  final VoidCallback onEdit;

  /// Callback used to remove this habit.
  final VoidCallback onDelete;

  /// Creates [HabitListItem].
  const HabitListItem({
    required this.habit,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = appL10n(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final deleteActionColor = isDarkMode
        ? colorScheme.error
        : colorScheme.tertiary;
    final isDoneToday = habit.isCompletedToday();
    final streak = habit.calculateStreak();
    final iconPalette = habitIconPaletteFromKey(habit.iconName);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.all(Radius.circular(_cardRadius)),
        boxShadow: AppEffects.ambientShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: _iconBadgeSize,
                height: _iconBadgeSize,
                decoration: BoxDecoration(
                  color: iconPalette.background,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(_badgeRadius),
                  ),
                ),
                child: Icon(
                  habitIconFromKey(habit.iconName),
                  color: iconPalette.foreground,
                ),
              ),
              const Spacer(),
              AnimatedStreakBadge(streak: streak),
              const SizedBox(width: 6),
              PopupMenuButton<_HabitAction>(
                tooltip: l10n.habitActionsTooltip,
                surfaceTintColor: Colors.transparent,
                color: colorScheme.surfaceContainerLowest,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                elevation: 8,
                offset: const Offset(0, 6),
                onSelected: (action) {
                  switch (action) {
                    case _HabitAction.edit:
                      onEdit();
                    case _HabitAction.delete:
                      onDelete();
                  }
                },
                itemBuilder: (_) {
                  return [
                    PopupMenuItem<_HabitAction>(
                      value: _HabitAction.edit,
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 10),
                          Text(l10n.editAction),
                        ],
                      ),
                    ),
                    PopupMenuItem<_HabitAction>(
                      value: _HabitAction.delete,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: deleteActionColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            l10n.deleteAction,
                            style: isDarkMode
                                ? TextStyle(color: deleteActionColor)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                child: SizedBox(
                  width: 34,
                  height: 34,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Icon(
                      Icons.more_horiz,
                      size: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(habit.name, style: Theme.of(context).textTheme.titleLarge),
          if (habit.description.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              habit.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                isDoneToday ? l10n.completedToday : l10n.tapToComplete,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDoneToday
                      ? colorScheme.secondary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              AnimatedCompletionToggleButton(
                isCompleted: isDoneToday,
                onTap: onToggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _HabitAction { edit, delete }
