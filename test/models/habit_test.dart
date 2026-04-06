import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/models/habit.dart';

void main() {
  group('Habit streak tests', () {
    test('streak counts consecutive days including today', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final twoDaysAgo = today.subtract(const Duration(days: 2));

      final habit = Habit(
        id: '1',
        name: 'Test',
        completedDays: [today, yesterday, twoDaysAgo],
      );

      expect(habit.calculateStreak(), 3);
    });

    test('streak breaks when a day is missing', () {
      final today = DateTime.now();
      final twoDaysAgo = today.subtract(const Duration(days: 2));

      final habit = Habit(
        id: '1',
        name: 'Test',
        completedDays: [today, twoDaysAgo],
      );

      expect(habit.calculateStreak(), 1);
    });

    test('streak is 0 if last completion was long ago', () {
      final habit = Habit(
        id: '1',
        name: 'Test',
        completedDays: [DateTime.now().subtract(const Duration(days: 5))],
      );

      expect(habit.calculateStreak(), 0);
    });

    test('streak counts only most recent consecutive days', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final threeDaysAgo = today.subtract(const Duration(days: 3));

      final habit = Habit(
        id: '1',
        name: 'Test',
        completedDays: [today, yesterday, threeDaysAgo],
      );

      expect(habit.calculateStreak(), 2);
    });

    test('streak works with unordered list of completed days', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final twoDaysAgo = today.subtract(const Duration(days: 2));

      final habit = Habit(
        id: '1',
        name: 'Test',
        completedDays: [yesterday, today, twoDaysAgo],
      );

      expect(habit.calculateStreak(), 3);
    });

    test('isCompletedToday returns true if today is in completedDays', () {
      final habit = Habit(
        id: '1',
        name: 'Test',
        completedDays: [DateTime.now()],
      );

      expect(habit.isCompletedToday(), true);
    });

    test('isCompletedToday returns false if today is not in completedDays', () {
      final habit = Habit(
        id: '1',
        name: 'Test',
        completedDays: [DateTime.now().subtract(const Duration(days: 1))],
      );

      expect(habit.isCompletedToday(), false);
    });
  });
}
