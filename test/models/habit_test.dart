import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/models/habit.dart';

void main() {
  group('Habit streak tests', () {
    const int oneDay = 1;
    const int twoDays = 2;
    const int threeDays = 3;
    const int fiveDays = 5;

    test('streak counts consecutive days including today', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: oneDay));
      final twoDaysAgo = today.subtract(const Duration(days: twoDays));

      final habit = Habit(
        id: '1',
        name: 'Test Habit',
        completedDays: [today, yesterday, twoDaysAgo],
      );

      const expectedStreak = 3;
      expect(habit.calculateStreak(), expectedStreak);
    });

    test('streak breaks when a day is missing', () {
      final today = DateTime.now();
      final twoDaysAgo = today.subtract(const Duration(days: twoDays));

      final habit = Habit(
        id: '1',
        name: 'Test Habit',
        completedDays: [today, twoDaysAgo],
      );

      const expectedStreak = 1;
      expect(habit.calculateStreak(), expectedStreak);
    });

    test('streak is 0 if last completion was long ago', () {
      final lastCompletion = DateTime.now().subtract(
        const Duration(days: fiveDays),
      );

      final habit = Habit(
        id: '1',
        name: 'Test Habit',
        completedDays: [lastCompletion],
      );

      const expectedStreak = 0;
      expect(habit.calculateStreak(), expectedStreak);
    });

    test('streak counts only most recent consecutive days', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: oneDay));
      final threeDaysAgo = today.subtract(const Duration(days: threeDays));

      final habit = Habit(
        id: '1',
        name: 'Test Habit',
        completedDays: [today, yesterday, threeDaysAgo],
      );

      const expectedStreak = 2;
      expect(habit.calculateStreak(), expectedStreak);
    });

    test('streak works with unordered list of completed days', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: oneDay));
      final twoDaysAgo = today.subtract(const Duration(days: twoDays));

      final habit = Habit(
        id: '1',
        name: 'Test Habit',
        completedDays: [yesterday, today, twoDaysAgo],
      );

      const expectedStreak = 3;
      expect(habit.calculateStreak(), expectedStreak);
    });

    test('isCompletedToday returns true if today is in completedDays', () {
      final habit = Habit(
        id: '1',
        name: 'Test Habit',
        completedDays: [DateTime.now()],
      );

      expect(habit.isCompletedToday(), true);
    });

    test('isCompletedToday returns false if today is not in completedDays', () {
      final habit = Habit(
        id: '1',
        name: 'Test Habit',
        completedDays: [DateTime.now().subtract(const Duration(days: oneDay))],
      );

      expect(habit.isCompletedToday(), false);
    });

    test('description and iconName have sensible defaults', () {
      const habit = Habit(
        id: '1',
        name: 'Test Habit',
        completedDays: [],
      );

      expect(habit.description, '');
      expect(habit.iconName, 'task_alt');
    });

    test('toJson and fromJson keep all fields', () {
      final today = DateTime.now();
      final habit = Habit(
        id: '1',
        name: 'Hydration',
        description: 'Drink 2L of water',
        iconName: 'water_drop',
        completedDays: [today],
      );

      final encoded = habit.toJson();
      final decoded = Habit.fromJson(encoded);

      expect(decoded.id, habit.id);
      expect(decoded.name, habit.name);
      expect(decoded.description, habit.description);
      expect(decoded.iconName, habit.iconName);
      expect(decoded.completedDays.length, habit.completedDays.length);
      expect(decoded.completedDays.first.isAtSameMomentAs(today), true);
    });
  });
}
