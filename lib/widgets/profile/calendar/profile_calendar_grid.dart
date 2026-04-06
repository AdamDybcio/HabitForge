// ignore_for_file: public_member_api_docs

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:habit_forge/core/extensions/date_extensions.dart';

class ProfileCalendarGrid extends StatelessWidget {
  static const _weekLength = 7;
  static const _roundingOffset = 6;

  final DateTime focusedMonth;
  final DateTime selectedDay;
  final Map<DateTime, int> completionCountByDay;
  final ValueChanged<DateTime> onSelectDay;

  const ProfileCalendarGrid({
    required this.focusedMonth,
    required this.selectedDay,
    required this.completionCountByDay,
    required this.onSelectDay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _totalCells,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _weekLength,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (_, index) {
        final day = _dayForIndex(index);

        if (day == null) {
          return const SizedBox.shrink();
        }

        final count = completionCountByDay[_dateKey(day)] ?? 0;

        return _ProfileCalendarDayCell(
          day: day,
          count: count,
          selectedDay: selectedDay,
          onTap: () => onSelectDay(day),
        );
      },
    );
  }

  int get _totalCells {
    return ((_firstWeekdayOffset + _daysInMonth + _roundingOffset) ~/
            _weekLength) *
        _weekLength;
  }

  int get _firstWeekdayOffset => _firstDay.weekday - DateTime.monday;

  DateTime get _firstDay => DateTime(focusedMonth.year, focusedMonth.month);

  int get _daysInMonth {
    return DateUtils.getDaysInMonth(focusedMonth.year, focusedMonth.month);
  }

  DateTime? _dayForIndex(int index) {
    final dayNumber = index - _firstWeekdayOffset + 1;

    if (dayNumber < 1 || dayNumber > _daysInMonth) {
      return null;
    }

    return DateTime(focusedMonth.year, focusedMonth.month, dayNumber);
  }

  DateTime _dateKey(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}

class _ProfileCalendarDayCell extends StatelessWidget {
  static const _intensityDivisor = 4.0;
  static const _maxIntensity = 1.0;
  static const _emptyDayOpacity = 0.03;
  static const _baseDayOpacity = 0.08;
  static const _intensityOpacityScale = 0.25;
  static const _selectedCountOpacity = 0.92;
  static const _todayBorderOpacity = 0.65;
  static const _defaultBorderOpacity = 0.2;

  final DateTime day;
  final int count;
  final DateTime selectedDay;
  final VoidCallback onTap;

  const _ProfileCalendarDayCell({
    required this.day,
    required this.count,
    required this.selectedDay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isToday = day.isSameDay(DateTime.now());
    final isSelected = day.isSameDay(selectedDay);
    final intensity = math.min(count / _intensityDivisor, _maxIntensity);

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: _backgroundColor(colorScheme, isSelected, intensity),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: _borderColor(colorScheme, isToday)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day.day.toString(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : colorScheme.onSurface,
              ),
            ),
            if (count > 0)
              Text(
                count.toString(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? Colors.white.withValues(alpha: _selectedCountOpacity)
                      : colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _backgroundColor(
    ColorScheme colorScheme,
    bool isSelected,
    double intensity,
  ) {
    if (isSelected) {
      return colorScheme.primary;
    }

    return colorScheme.primary.withValues(
      alpha: count == 0
          ? _emptyDayOpacity
          : _baseDayOpacity + intensity * _intensityOpacityScale,
    );
  }

  Color _borderColor(ColorScheme colorScheme, bool isToday) {
    if (isToday) {
      return colorScheme.primary.withValues(alpha: _todayBorderOpacity);
    }

    return colorScheme.outlineVariant.withValues(alpha: _defaultBorderOpacity);
  }
}
