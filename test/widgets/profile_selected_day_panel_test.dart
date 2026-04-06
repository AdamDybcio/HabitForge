import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/profile/profile_selected_day_panel.dart';

void main() {
  const expectedCompletedHabitCount = 2;

  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  group('ProfileSelectedDayPanel', () {
    testWidgets('shows empty-state message when no habits are completed', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          ProfileSelectedDayPanel(
            selectedDay: DateTime(2026, 4, 7),
            completedHabits: const <Habit>[],
          ),
        ),
      );

      expect(find.textContaining('Completed on'), findsOneWidget);
      expect(find.text('No completed habits on this day.'), findsOneWidget);
    });

    testWidgets('renders chips for completed habits', (tester) async {
      final habits = [
        const Habit(id: 'h1', name: 'Read', completedDays: <DateTime>[]),
        const Habit(id: 'h2', name: 'Workout', completedDays: <DateTime>[]),
      ];

      await tester.pumpWidget(
        wrap(
          ProfileSelectedDayPanel(
            selectedDay: DateTime(2026, 4, 7),
            completedHabits: habits,
          ),
        ),
      );

      expect(find.text('Read'), findsOneWidget);
      expect(find.text('Workout'), findsOneWidget);
      expect(find.byType(Chip), findsNWidgets(expectedCompletedHabitCount));
    });
  });
}
