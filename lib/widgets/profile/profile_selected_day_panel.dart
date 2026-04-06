// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/colors.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:intl/intl.dart';

/// Panel with selected-day completion details.
class ProfileSelectedDayPanel extends StatelessWidget {
  final DateTime selectedDay;
  final List<Habit> completedHabits;

  /// Creates [ProfileSelectedDayPanel].
  const ProfileSelectedDayPanel({
    required this.selectedDay,
    required this.completedHabits,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dayLabel = DateFormat('EEE, MMM d').format(selectedDay);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        boxShadow: AppEffects.ambientShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Completed on $dayLabel',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          if (completedHabits.isEmpty)
            Text(
              'No completed habits on this day.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: completedHabits
                  .map(
                    (habit) => Chip(
                      label: Text(habit.name),
                      backgroundColor: colorScheme.surfaceContainerLow,
                      side: BorderSide(
                        color: colorScheme.outlineVariant.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
