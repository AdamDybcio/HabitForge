// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class ProfileCalendarWeekLabels extends StatelessWidget {
  static const _weekLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  const ProfileCalendarWeekLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: _weekLabels
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
