// ignore_for_file: prefer_match_file_name
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/services/habit_local_storage_service.dart';
import 'package:habit_forge/services/local_notifications_service.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';

class InMemoryHabitStorageService extends HabitLocalStorageService {
  List<Habit> storedHabits;
  bool failOnLoad;
  bool failOnSave;

  InMemoryHabitStorageService({
    List<Habit>? initialHabits,
    this.failOnLoad = false,
    this.failOnSave = false,
  }) : storedHabits = List<Habit>.from(initialHabits ?? const <Habit>[]);

  @override
  Future<List<Habit>> loadHabits() async {
    if (failOnLoad) {
      throw Exception('load failed');
    }

    return List<Habit>.from(storedHabits);
  }

  @override
  Future<void> saveHabits(List<Habit> habits) async {
    if (failOnSave) {
      throw Exception('save failed');
    }

    storedHabits = List<Habit>.from(habits);
  }
}

class FixedUuid extends Uuid {
  final List<String> _ids;
  int _index = 0;

  FixedUuid(List<String> ids)
    : _ids = ids.isEmpty ? <String>['fixed-id'] : List<String>.from(ids);

  @override
  String v4({Map<String, dynamic>? options, V4Options? config}) {
    if (_index >= _ids.length) {
      return _ids.last;
    }

    final value = _ids[_index];
    _index++;

    return value;
  }
}

class InMemoryReminderScheduler implements HabitReminderScheduler {
  final Set<String> scheduledHabitIds = <String>{};
  bool initializeCalled = false;
  bool syncCalled = false;

  @override
  Future<void> initialize() async {
    initializeCalled = true;
  }

  @override
  Future<void> syncHabitReminders(List<Habit> habits) async {
    syncCalled = true;
    scheduledHabitIds
      ..clear()
      ..addAll(
        habits.where((habit) => habit.hasReminder).map((habit) => habit.id),
      );
  }

  @override
  Future<void> scheduleHabitReminder(Habit habit) async {
    if (habit.hasReminder) {
      scheduledHabitIds.add(habit.id);
    } else {
      scheduledHabitIds.remove(habit.id);
    }
  }

  @override
  Future<void> cancelHabitReminder(String habitId) async {
    scheduledHabitIds.remove(habitId);
  }
}
