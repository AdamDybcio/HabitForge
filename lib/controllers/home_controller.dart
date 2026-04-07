import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:habit_forge/core/extensions/date_extensions.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/services/habit_local_storage_service.dart';
import 'package:habit_forge/services/local_notifications_service.dart';
import 'package:uuid/uuid.dart';

/// Home controller for habits state and business operations.
class HomeController extends ChangeNotifier {
  final HabitLocalStorageService _storage;
  final HabitReminderScheduler _reminderScheduler;
  final Uuid _uuid;
  final bool _enableDayRolloverTicker;
  Timer? _dayRolloverTimer;

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
    HabitReminderScheduler? reminderScheduler,
    Uuid? uuid,
    bool enableDayRolloverTicker = true,
  }) : _storage = storage,
       _reminderScheduler = reminderScheduler ?? NoopHabitReminderScheduler(),
       _uuid = uuid ?? const Uuid(),
       _enableDayRolloverTicker = enableDayRolloverTicker {
    if (!_enableDayRolloverTicker) {
      return;
    }

    _scheduleDayRolloverTick();
  }

  /// Loads habits from local storage.
  Future<void> initialize() async {
    _setLoading(true);

    try {
      _errorMessage = null;
      final loadedHabits = await _storage.loadHabits();
      _habits
        ..clear()
        ..addAll(loadedHabits);
      await _reminderScheduler.syncHabitReminders(_habits);
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
    bool reminderEnabled = false,
    int? reminderHour,
    int? reminderMinute,
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
      reminderEnabled: reminderEnabled,
      reminderHour: reminderEnabled ? reminderHour : null,
      reminderMinute: reminderEnabled ? reminderMinute : null,
    );

    _habits.add(habit);
    notifyListeners();
    final persisted = await _persist();

    if (persisted) {
      await _reminderScheduler.scheduleHabitReminder(habit);
    }
  }

  /// Updates an existing habit and persists it.
  Future<void> updateHabit({
    required String habitId,
    required String name,
    String description = '',
    String iconName = 'task_alt',
    bool reminderEnabled = false,
    int? reminderHour,
    int? reminderMinute,
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
    final updated = existing.copyWith(
      name: trimmedName,
      description: description.trim(),
      iconName: iconName,
      reminderEnabled: reminderEnabled,
      reminderHour: reminderEnabled ? reminderHour : null,
      reminderMinute: reminderEnabled ? reminderMinute : null,
      clearReminderTime: !reminderEnabled,
    );
    _habits[index] = updated;
    notifyListeners();
    final persisted = await _persist();

    if (!persisted) {
      return;
    }

    if (updated.hasReminder) {
      await _reminderScheduler.scheduleHabitReminder(updated);
    } else {
      await _reminderScheduler.cancelHabitReminder(updated.id);
    }
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

    final updatedHabit = habit.copyWith(completedDays: updatedDays);
    _habits[index] = updatedHabit;
    notifyListeners();
    final persisted = await _persist();

    if (!persisted || !updatedHabit.hasReminder) {
      return;
    }

    await _reminderScheduler.scheduleHabitReminder(updatedHabit);
  }

  /// Removes an existing habit and persists the result.
  Future<void> removeHabit(String habitId) async {
    final existingCount = _habits.length;
    _habits.removeWhere((habit) => habit.id == habitId);
    final removedAny = _habits.length < existingCount;
    notifyListeners();
    final persisted = await _persist();

    if (persisted && removedAny) {
      await _reminderScheduler.cancelHabitReminder(habitId);
    }
  }

  Future<bool> _persist() async {
    try {
      _errorMessage = null;
      await _storage.saveHabits(_habits);
      notifyListeners();

      return true;
    } catch (_) {
      _errorMessage = 'Nie udało się zapisać zmian.';
      notifyListeners();

      return false;
    }
  }

  void _scheduleDayRolloverTick() {
    _dayRolloverTimer?.cancel();

    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final delay = nextMidnight.difference(now) + const Duration(seconds: 1);

    _dayRolloverTimer = Timer(delay, () {
      if (!hasListeners) {
        _scheduleDayRolloverTick();

        return;
      }

      unawaited(_reminderScheduler.syncHabitReminders(_habits));
      notifyListeners();
      _scheduleDayRolloverTick();
    });
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _dayRolloverTimer?.cancel();
    super.dispose();
  }
}
