import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/views/profile_screen.dart';
import 'package:provider/provider.dart';

import '../support/test_doubles.dart';

void main() {
  Widget wrap({required HomeController controller}) {
    return MaterialApp(
      home: ChangeNotifierProvider<HomeController>.value(
        value: controller,
        child: const Scaffold(body: ProfileScreen()),
      ),
    );
  }

  group('ProfileScreen', () {
    testWidgets('renders profile sections with aggregated data', (
      tester,
    ) async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));

      final habits = [
        Habit(
          id: 'h1',
          name: 'Read',
          completedDays: [today, yesterday],
        ),
        Habit(
          id: 'h2',
          name: 'Workout',
          completedDays: [today],
        ),
      ];

      final controller = HomeController(
        storage: InMemoryHabitStorageService(initialHabits: habits),
        enableDayRolloverTicker: false,
      );
      await controller.initialize();

      await tester.pumpWidget(wrap(controller: controller));
      await tester.pumpAndSettle();

      expect(find.text('Profile'), findsOneWidget);
      expect(
        find.text(
          'Track consistency, review your history, and plan your next streak.',
        ),
        findsOneWidget,
      );

      expect(find.text('Today'), findsOneWidget);
      expect(find.text('All Time'), findsOneWidget);
      expect(find.text('Last 7 days'), findsOneWidget);
      expect(find.textContaining('Completed on'), findsOneWidget);

      expect(find.text('2/2'), findsOneWidget);
      expect(find.text('100%'), findsOneWidget);
      expect(find.text('3'), findsWidgets);
      expect(find.text('Read'), findsWidgets);
      expect(find.text('Workout'), findsWidgets);
    });
  });
}
