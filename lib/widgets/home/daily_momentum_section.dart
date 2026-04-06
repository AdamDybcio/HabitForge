import 'package:flutter/material.dart';
import 'package:habit_forge/widgets/home/components/animated_completion_progress.dart';
import 'package:intl/intl.dart';

/// Daily momentum section with date, title and completion progress.
class DailyMomentumSection extends StatelessWidget {
  static const _progressCardRadius = 24.0;

  /// Number of habits completed today.
  final int completedToday;

  /// Total number of habits.
  final int totalHabits;

  /// Creates [DailyMomentumSection].
  const DailyMomentumSection({
    required this.completedToday,
    required this.totalHabits,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final formattedDate = DateFormat('EEEE, MMM d', localeTag).format(
      DateTime.now(),
    );
    const letterSpacing = 1.5; // Tighter spacing for uppercase labels

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            letterSpacing: letterSpacing,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Daily Momentum',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: const BorderRadius.all(
              Radius.circular(_progressCardRadius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedCompletionProgress(
                completed: completedToday,
                total: totalHabits,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
