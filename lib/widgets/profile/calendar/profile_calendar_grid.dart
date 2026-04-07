// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/widgets/profile/calendar/components/profile_calendar_day_cell.dart';

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

        return ProfileCalendarDayCell(
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
