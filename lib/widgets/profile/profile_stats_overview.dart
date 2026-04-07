// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';
import 'package:habit_forge/widgets/profile/components/profile_stat_card.dart';

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
    final l10n = appL10n(context);
    final completionRate = totalHabits == 0
        ? 0
        : ((completedToday / totalHabits) * 100).round();

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ProfileStatCard(
          title: l10n.statsToday,
          value: '$completedToday/$totalHabits',
          subtitle: l10n.statsHabitsDone,
          color: colorScheme.primary,
        ),
        ProfileStatCard(
          title: l10n.statsCompletion,
          value: '$completionRate%',
          subtitle: l10n.statsDailySuccess,
          color: colorScheme.secondary,
        ),
        ProfileStatCard(
          title: l10n.statsAllTime,
          value: '$totalCompletions',
          subtitle: l10n.statsCompletions,
          color: colorScheme.primaryContainer,
        ),
        ProfileStatCard(
          title: l10n.statsBestStreak,
          value: '$bestCurrentStreak',
          subtitle: l10n.statsCurrentStreakMax,
          color: colorScheme.tertiary,
        ),
      ],
    );
  }
}
