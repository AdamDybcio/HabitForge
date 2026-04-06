import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/models/habit.dart';
import '../support/test_doubles.dart';

void main() {
  group('HomeController', () {
    test('initialize loads habits from storage', () async {
      const existing = Habit(
        id: 'h-1',
        name: 'Drink water',
        description: '2L',
        iconName: 'water_drop',
        completedDays: <DateTime>[],
      );
      final storage = InMemoryHabitStorageService(initialHabits: [existing]);
      final controller = HomeController(
        storage: storage,
        enableDayRolloverTicker: false,
      );

      await controller.initialize();

      expect(controller.habits, [existing]);
      expect(controller.isLoading, isFalse);
      expect(controller.errorMessage, isNull);
    });

    test('initialize sets error message when load fails', () async {
      final storage = InMemoryHabitStorageService(failOnLoad: true);
      final controller = HomeController(
        storage: storage,
        enableDayRolloverTicker: false,
      );

      await controller.initialize();

      expect(controller.habits, isEmpty);
      expect(controller.isLoading, isFalse);
      expect(controller.errorMessage, 'Nie udało się wczytać nawyków.');
    });

    test('addHabit trims values and persists', () async {
      final storage = InMemoryHabitStorageService();
      final controller = HomeController(
        storage: storage,
        uuid: FixedUuid(['habit-id-1']),
        enableDayRolloverTicker: false,
      );

      await controller.addHabit(
        name: '  Read 10 pages  ',
        description: '  Before bed  ',
        iconName: 'book',
      );

      expect(controller.habits, hasLength(1));
      final habit = controller.habits.single;
      expect(habit.id, 'habit-id-1');
      expect(habit.name, 'Read 10 pages');
      expect(habit.description, 'Before bed');
      expect(habit.iconName, 'book');
      expect(storage.storedHabits, hasLength(1));
    });

    test('addHabit ignores empty names', () async {
      final storage = InMemoryHabitStorageService();
      final controller = HomeController(
        storage: storage,
        enableDayRolloverTicker: false,
      );

      await controller.addHabit(name: '   ');

      expect(controller.habits, isEmpty);
      expect(storage.storedHabits, isEmpty);
    });

    test('updateHabit updates existing habit and persists', () async {
      const existing = Habit(
        id: 'habit-1',
        name: 'Old name',
        description: 'Old desc',
        completedDays: <DateTime>[],
      );
      final storage = InMemoryHabitStorageService(initialHabits: [existing]);
      final controller = HomeController(
        storage: storage,
        enableDayRolloverTicker: false,
      );
      await controller.initialize();

      await controller.updateHabit(
        habitId: 'habit-1',
        name: '  New name ',
        description: ' Updated ',
        iconName: 'water_drop',
      );

      final updated = controller.habits.single;
      expect(updated.name, 'New name');
      expect(updated.description, 'Updated');
      expect(updated.iconName, 'water_drop');
      expect(storage.storedHabits.single.name, 'New name');
    });

    test('toggleHabitCompletion adds and removes selected day', () async {
      final day = DateTime(2026, 4, 6);
      const existing = Habit(
        id: 'habit-1',
        name: 'Workout',
        completedDays: <DateTime>[],
      );
      final storage = InMemoryHabitStorageService(initialHabits: [existing]);
      final controller = HomeController(
        storage: storage,
        enableDayRolloverTicker: false,
      );
      await controller.initialize();

      await controller.toggleHabitCompletion('habit-1', day: day);
      expect(controller.habits.single.completedDays, [day]);

      await controller.toggleHabitCompletion('habit-1', day: day);
      expect(controller.habits.single.completedDays, isEmpty);
    });

    test('removeHabit removes habit and persists', () async {
      const first = Habit(
        id: 'h1',
        name: 'A',
        completedDays: <DateTime>[],
      );
      const second = Habit(
        id: 'h2',
        name: 'B',
        completedDays: <DateTime>[],
      );
      final storage = InMemoryHabitStorageService(
        initialHabits: [first, second],
      );
      final controller = HomeController(
        storage: storage,
        enableDayRolloverTicker: false,
      );
      await controller.initialize();

      await controller.removeHabit('h1');

      expect(controller.habits, [second]);
      expect(storage.storedHabits, [second]);
    });

    test('sets save error when persistence fails', () async {
      final storage = InMemoryHabitStorageService(failOnSave: true);
      final controller = HomeController(
        storage: storage,
        uuid: FixedUuid(['habit-id-1']),
        enableDayRolloverTicker: false,
      );

      await controller.addHabit(name: 'Drink water');

      expect(controller.habits, hasLength(1));
      expect(controller.errorMessage, 'Nie udało się zapisać zmian.');
    });
  });
}
