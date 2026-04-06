import 'package:flutter/material.dart';
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
    final isDoneToday = habit.isCompletedToday();
    final streak = habit.calculateStreak();
    final iconPalette = habitIconPaletteFromKey(habit.iconName);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.all(Radius.circular(_cardRadius)),
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
                tooltip: 'Habit actions',
                surfaceTintColor: Colors.transparent,
                color: AppColors.surfaceContainerLowest,
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
                          const Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem<_HabitAction>(
                      value: _HabitAction.delete,
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, color: AppColors.tertiary),
                          SizedBox(width: 10),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ];
                },
                child: const SizedBox(
                  width: 34,
                  height: 34,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Icon(
                      Icons.more_horiz,
                      size: 18,
                      color: AppColors.onSurfaceVariant,
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
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                isDoneToday ? 'Completed today' : 'Tap to complete',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDoneToday
                      ? AppColors.secondary
                      : AppColors.onSurfaceVariant,
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
