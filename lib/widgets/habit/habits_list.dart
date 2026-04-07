import 'package:flutter/material.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/habit/habits_list_state.dart';

/// Home content showing loading, empty state or habits list.
class HabitsList extends StatefulWidget {
  /// Controller providing habits data and actions.
  final HomeController controller;

  /// Action used to start create-habit flow.
  final VoidCallback onCreateHabit;

  /// Action used to start edit-habit flow.
  final ValueChanged<Habit> onEditHabit;

  /// Action used to request deleting a habit.
  final ValueChanged<Habit> onDeleteHabit;

  /// Creates [HabitsList].
  const HabitsList({
    required this.controller,
    required this.onCreateHabit,
    required this.onEditHabit,
    required this.onDeleteHabit,
    super.key,
  });

  @override
  State<HabitsList> createState() => HabitsListState();
}
