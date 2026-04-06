// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Compact metrics section for profile statistics.
class ProfileStatsOverview extends StatelessWidget {
  final int totalHabits;
  final int completedToday;
  final int totalCompletions;
  final int bestCurrentStreak;

  /// Creates [ProfileStatsOverview].
  const ProfileStatsOverview({
    required this.totalHabits,
    required this.completedToday,
    required this.totalCompletions,
    required this.bestCurrentStreak,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final completionRate = totalHabits == 0
        ? 0
        : ((completedToday / totalHabits) * 100).round();

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _StatCard(
          title: 'Today',
          value: '$completedToday/$totalHabits',
          subtitle: 'Habits done',
          color: colorScheme.primary,
        ),
        _StatCard(
          title: 'Completion',
          value: '$completionRate%',
          subtitle: 'Daily success',
          color: colorScheme.secondary,
        ),
        _StatCard(
          title: 'All Time',
          value: '$totalCompletions',
          subtitle: 'Completions',
          color: colorScheme.primaryContainer,
        ),
        _StatCard(
          title: 'Best Streak',
          value: '$bestCurrentStreak',
          subtitle: 'Current streak max',
          color: colorScheme.tertiary,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  static const _cardWidth = 160.0;

  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: _cardWidth,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
