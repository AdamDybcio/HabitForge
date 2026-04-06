// ignore_for_file: prefer_match_file_name
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/services/habit_local_storage_service.dart';
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
