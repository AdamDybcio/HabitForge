import 'package:flutter/material.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/core/extensions/date_extensions.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/views/profile_screen.dart';
import 'package:habit_forge/widgets/profile/profile_monthly_calendar.dart';
import 'package:habit_forge/widgets/profile/profile_selected_day_panel.dart';
import 'package:habit_forge/widgets/profile/profile_stats_overview.dart';
import 'package:habit_forge/widgets/profile/profile_weekly_chart.dart';
import 'package:provider/provider.dart';

/// State object for [ProfileScreen].
class ProfileScreenState extends State<ProfileScreen> {
  static const _daysInWeek = 7;
  static const _weeklyBackOffset = 6;

  DateTime _focusedMonth = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    final today = _dateOnly(DateTime.now());
    _focusedMonth = DateTime(today.year, today.month);
    _selectedDay = today;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = appL10n(context);
    final controller = context.watch<HomeController>();
    final habits = controller.habits;
    final completionCountByDay = _buildCompletionCountByDay(habits);
    final completedToday = habits
        .where((habit) => habit.isCompletedToday())
        .length;
    final totalCompletions = habits.fold<int>(
      0,
      (sum, habit) => sum + habit.completedDays.length,
    );
    final bestCurrentStreak = habits.isEmpty
        ? 0
        : habits
              .map((habit) => habit.calculateStreak())
              .reduce((a, b) => a > b ? a : b);
    final completedOnSelectedDay = habits
        .where(
          (habit) =>
              habit.completedDays.any((day) => day.isSameDay(_selectedDay)),
        )
        .toList();
    final weeklyCompletions = _buildWeeklyCompletions(completionCountByDay);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.profileTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 6),
            Text(
              l10n.profileSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            ProfileStatsOverview(
              totalHabits: habits.length,
              completedToday: completedToday,
              totalCompletions: totalCompletions,
              bestCurrentStreak: bestCurrentStreak,
            ),
            const SizedBox(height: 16),
            ProfileMonthlyCalendar(
              focusedMonth: _focusedMonth,
              selectedDay: _selectedDay,
              completionCountByDay: completionCountByDay,
              onSelectDay: _onSelectDay,
              onPreviousMonth: () {
                setState(() {
                  _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month - 1,
                  );
                });
              },
              onNextMonth: () {
                setState(() {
                  _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month + 1,
                  );
                });
              },
            ),
            const SizedBox(height: 16),
            ProfileSelectedDayPanel(
              selectedDay: _selectedDay,
              completedHabits: completedOnSelectedDay,
            ),
            const SizedBox(height: 16),
            ProfileWeeklyChart(completions: weeklyCompletions),
          ],
        ),
      ),
    );
  }

  void _onSelectDay(DateTime day) {
    setState(() {
      _selectedDay = _dateOnly(day);
      _focusedMonth = DateTime(day.year, day.month);
    });
  }

  Map<DateTime, int> _buildCompletionCountByDay(List<Habit> habits) {
    final map = <DateTime, int>{};

    for (final habit in habits) {
      for (final day in habit.completedDays) {
        final key = _dateOnly(day);
        map[key] = (map[key] ?? 0) + 1;
      }
    }

    return map;
  }

  List<int> _buildWeeklyCompletions(Map<DateTime, int> completionCountByDay) {
    final today = _dateOnly(DateTime.now());

    return List<int>.generate(_daysInWeek, (index) {
      final date = today.subtract(
        Duration(days: _weeklyBackOffset - index),
      );

      return completionCountByDay[date] ?? 0;
    });
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
