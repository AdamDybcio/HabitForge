// ignore_for_file: public_member_api_docs

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:habit_forge/core/extensions/date_extensions.dart';

/// Single day cell in profile calendar grid.
class ProfileCalendarDayCell extends StatelessWidget {
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

  /// Creates [ProfileCalendarDayCell].
  const ProfileCalendarDayCell({
    required this.day,
    required this.count,
    required this.selectedDay,
    required this.onTap,
    super.key,
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
