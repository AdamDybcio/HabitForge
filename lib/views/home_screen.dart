import 'package:flutter/material.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/habit/create_habit_bottom_sheet.dart';
import 'package:habit_forge/widgets/habit/habits_list.dart';
import 'package:habit_forge/widgets/home/daily_momentum_section.dart';
import 'package:habit_forge/widgets/home/home_header.dart';
import 'package:provider/provider.dart';

/// The home screen of the HabitForge application.
class HomeScreen extends StatelessWidget {
  /// Action used to open create-habit flow.
  final VoidCallback onCreateHabit;

  /// Creates a [HomeScreen] widget.
  const HomeScreen({
    required this.onCreateHabit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    final totalHabits = controller.habits.length;
    final completedToday = controller.habits
        .where((habit) => habit.isCompletedToday())
        .length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            const SizedBox(height: 18),
            DailyMomentumSection(
              completedToday: completedToday,
              totalHabits: totalHabits,
            ),
            const SizedBox(height: 18),
            Expanded(
              child: HabitsList(
                controller: controller,
                onCreateHabit: onCreateHabit,
                onEditHabit: (habit) => _openEditHabitSheet(context, habit),
                onDeleteHabit: (habit) => _confirmDeleteHabit(context, habit),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openEditHabitSheet(BuildContext context, Habit habit) {
    final controller = context.read<HomeController>();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return CreateHabitBottomSheet(
          controller: controller,
          initialHabit: habit,
        );
      },
    );
  }

  Future<void> _confirmDeleteHabit(BuildContext context, Habit habit) async {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final deleteContainerColor = isDarkMode
        ? colorScheme.errorContainer
        : colorScheme.tertiaryContainer;
    final deleteIconColor = isDarkMode
        ? colorScheme.error
        : colorScheme.tertiary;
    final deleteButtonColor = isDarkMode
        ? colorScheme.error
        : colorScheme.tertiary;
    final deleteButtonTextColor = isDarkMode
        ? colorScheme.onError
        : Colors.white;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: colorScheme.surfaceContainerLowest,
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 22, 24, 8),
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          title: const Text('Delete habit?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: deleteContainerColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: deleteIconColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'This will permanently remove "${habit.name}" from your list.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: deleteButtonColor,
                      foregroundColor: deleteButtonTextColor,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (shouldDelete != true || !context.mounted) {
      return;
    }

    await context.read<HomeController>().removeHabit(habit.id);
  }
}
