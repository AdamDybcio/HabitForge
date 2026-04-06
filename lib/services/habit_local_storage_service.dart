import 'package:habit_forge/models/habit.dart';
import 'package:hive/hive.dart';

/// Handles local persistence for habits using Hive.
class HabitLocalStorageService {
  static const _boxName = 'habit_forge_habits_box';
  static const _habitsKey = 'habits';

  Future<Box<dynamic>> _openBox() {
    return Hive.openBox<dynamic>(_boxName);
  }

  /// Loads all habits from local storage.
  Future<List<Habit>> loadHabits() async {
    final box = await _openBox();
    final storedValue = box.get(_habitsKey, defaultValue: <dynamic>[]);

    if (storedValue is! List) {
      return <Habit>[];
    }

    return storedValue
        .whereType<Map<dynamic, dynamic>>()
        .map(
          (item) => Habit.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList();
  }

  /// Persists the full habits list in local storage.
  Future<void> saveHabits(List<Habit> habits) async {
    final box = await _openBox();
    final payload = habits.map((habit) => habit.toJson()).toList();

    await box.put(_habitsKey, payload);
  }
}
