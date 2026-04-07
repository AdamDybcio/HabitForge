import 'package:flutter/material.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/habit/create_habit_bottom_sheet_state.dart';

/// Bottom sheet with form for creating a new habit.
class CreateHabitBottomSheet extends StatefulWidget {
  /// Controller used to persist a newly created habit.
  final HomeController controller;

  /// Habit being edited. When null, sheet works in create mode.
  final Habit? initialHabit;

  /// Creates [CreateHabitBottomSheet].
  const CreateHabitBottomSheet({
    required this.controller,
    this.initialHabit,
    super.key,
  });

  @override
  State<CreateHabitBottomSheet> createState() => CreateHabitBottomSheetState();
}
