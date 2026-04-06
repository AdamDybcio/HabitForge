import 'package:flutter/foundation.dart';
import 'package:habit_forge/core/extensions/date_extensions.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/services/habit_local_storage_service.dart';
import 'package:uuid/uuid.dart';

/// Home controller for habits state and business operations.
class HomeController extends ChangeNotifier {
  final HabitLocalStorageService _storage;
  final Uuid _uuid;

  final List<Habit> _habits = <Habit>[];
  bool _isLoading = false;
  String? _errorMessage;

  /// Read-only list of all habits displayed on home screen.
  List<Habit> get habits => List.unmodifiable(_habits);

  /// Indicates whether controller is currently loading persisted data.
  bool get isLoading => _isLoading;

  /// Last user-facing error for persistence operations, if any.
  String? get errorMessage => _errorMessage;

  /// Creates a controller for home screen logic and habits state.
  HomeController({
    required HabitLocalStorageService storage,
    Uuid? uuid,
  }) : _storage = storage,
       _uuid = uuid ?? const Uuid();

  /// Loads habits from local storage.
  Future<void> initialize() async {
    _setLoading(true);

    try {
      _errorMessage = null;
      final loadedHabits = await _storage.loadHabits();
      _habits
        ..clear()
        ..addAll(loadedHabits);
    } catch (_) {
      _errorMessage = 'Nie udało się wczytać nawyków.';
    } finally {
      _setLoading(false);
    }
  }

  /// Adds a new habit and persists it.
  Future<void> addHabit({
    required String name,
    String description = '',
    String iconName = 'task_alt',
  }) async {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return;
    }

    final habit = Habit(
      id: _uuid.v4(),
      name: trimmedName,
      description: description.trim(),
      iconName: iconName,
      completedDays: const <DateTime>[],
    );

    _habits.add(habit);
    notifyListeners();
    await _persist();
  }

  /// Updates an existing habit and persists it.
  Future<void> updateHabit({
    required String habitId,
    required String name,
    String description = '',
    String iconName = 'task_alt',
  }) async {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return;
    }

    final index = _habits.indexWhere((habit) => habit.id == habitId);

    if (index == -1) {
      return;
    }

    final existing = _habits[index];
    _habits[index] = existing.copyWith(
      name: trimmedName,
      description: description.trim(),
      iconName: iconName,
    );
    notifyListeners();
    await _persist();
  }

  /// Toggles completion for the selected day.
  Future<void> toggleHabitCompletion(String habitId, {DateTime? day}) async {
    final targetDay = day ?? DateTime.now();
    final index = _habits.indexWhere((habit) => habit.id == habitId);

    if (index == -1) {
      return;
    }

    final habit = _habits[index];
    final updatedDays = habit.completedDays.toList();
    final existingIndex = updatedDays.indexWhere((d) => d.isSameDay(targetDay));

    if (existingIndex >= 0) {
      updatedDays.removeAt(existingIndex);
    } else {
      updatedDays.add(targetDay);
    }

    _habits[index] = habit.copyWith(completedDays: updatedDays);
    notifyListeners();
    await _persist();
  }

  /// Removes an existing habit and persists the result.
  Future<void> removeHabit(String habitId) async {
    _habits.removeWhere((habit) => habit.id == habitId);
    notifyListeners();
    await _persist();
  }

  Future<void> _persist() async {
    try {
      _errorMessage = null;
      await _storage.saveHabits(_habits);
    } catch (_) {
      _errorMessage = 'Nie udało się zapisać zmian.';
    }

    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
