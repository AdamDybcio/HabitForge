// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/colors.dart';
import 'package:habit_forge/widgets/profile/calendar/profile_calendar_grid.dart';
import 'package:habit_forge/widgets/profile/calendar/profile_calendar_header.dart';
import 'package:habit_forge/widgets/profile/calendar/profile_calendar_week_labels.dart';

/// Monthly calendar with completion density per day.
class ProfileMonthlyCalendar extends StatelessWidget {
  final DateTime focusedMonth;
  final DateTime selectedDay;
  final Map<DateTime, int> completionCountByDay;
  final ValueChanged<DateTime> onSelectDay;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  /// Creates [ProfileMonthlyCalendar].
  const ProfileMonthlyCalendar({
    required this.focusedMonth,
    required this.selectedDay,
    required this.completionCountByDay,
    required this.onSelectDay,
    required this.onPreviousMonth,
    required this.onNextMonth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        boxShadow: AppEffects.ambientShadow,
      ),
      child: Column(
        children: [
          ProfileCalendarHeader(
            focusedMonth: focusedMonth,
            onPreviousMonth: onPreviousMonth,
            onNextMonth: onNextMonth,
          ),
          const SizedBox(height: 6),
          const ProfileCalendarWeekLabels(),
          const SizedBox(height: 8),
          ProfileCalendarGrid(
            focusedMonth: focusedMonth,
            selectedDay: selectedDay,
            completionCountByDay: completionCountByDay,
            onSelectDay: onSelectDay,
          ),
        ],
      ),
    );
  }
}
