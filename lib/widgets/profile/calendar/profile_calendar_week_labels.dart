// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/week_labels_helper.dart';

class ProfileCalendarWeekLabels extends StatelessWidget {
  const ProfileCalendarWeekLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final weekLabels = buildWeekdayShortLabels(localeTag);

    return Row(
      children: weekLabels
          .map(
            (label) => Expanded(
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
