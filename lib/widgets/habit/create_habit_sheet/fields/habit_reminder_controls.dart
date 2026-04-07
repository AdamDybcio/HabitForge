// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';

/// Reminder controls for create/edit habit form.
class HabitReminderControls extends StatelessWidget {
  final bool reminderEnabled;
  final TimeOfDay reminderTime;
  final ValueChanged<bool> onToggle;
  final VoidCallback onSelectTime;

  const HabitReminderControls({
    required this.reminderEnabled,
    required this.reminderTime,
    required this.onToggle,
    required this.onSelectTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = appL10n(context);
    final formattedTime = MaterialLocalizations.of(context).formatTimeOfDay(
      reminderTime,
      alwaysUse24HourFormat: true,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.habitReminderLabel),
                    const SizedBox(height: 2),
                    Text(
                      l10n.habitReminderDescription,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch.adaptive(
                value: reminderEnabled,
                onChanged: onToggle,
              ),
            ],
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOutBack,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            final slide = Tween<Offset>(
              begin: const Offset(0, -0.08),
              end: Offset.zero,
            ).animate(animation);

            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: -1,
                child: SlideTransition(position: slide, child: child),
              ),
            );
          },
          child: reminderEnabled
              ? Padding(
                  key: const ValueKey('reminder-time-visible'),
                  padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: onSelectTime,
                      icon: const Icon(Icons.schedule_rounded),
                      label: Text(l10n.habitReminderTime(formattedTime)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        alignment: Alignment.centerLeft,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('reminder-time-hidden')),
        ),
      ],
    );
  }
}
