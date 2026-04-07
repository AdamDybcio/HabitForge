import 'package:equatable/equatable.dart';
import 'package:habit_forge/core/extensions/date_extensions.dart';

/// A model representing a habit with its name and the days it was completed.
class Habit extends Equatable {
  /// Unique identifier for the habit.
  final String id;

  /// Name of the habit.
  final String name;

  /// Optional description shown in habit details.
  final String description;

  /// Semantic icon identifier used by the UI layer.
  final String iconName;

  /// List of dates when the habit was completed.
  final List<DateTime> completedDays;

  /// Whether a daily reminder is enabled for this habit.
  final bool reminderEnabled;

  /// Reminder hour in 24-hour format.
  final int? reminderHour;

  /// Reminder minute.
  final int? reminderMinute;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    iconName,
    completedDays,
    reminderEnabled,
    reminderHour,
    reminderMinute,
  ];

  /// Whether this habit has a valid reminder configuration.
  bool get hasReminder =>
      reminderEnabled && reminderHour != null && reminderMinute != null;

  /// Creates a new [Habit] instance.
  const Habit({
    required this.id,
    required this.name,
    required this.completedDays,
    this.description = '',
    this.iconName = 'task_alt',
    this.reminderEnabled = false,
    this.reminderHour,
    this.reminderMinute,
  });

  /// Creates a habit from a JSON map.
  factory Habit.fromJson(Map<String, dynamic> json) {
    final rawDays = json['completedDays'];
    final days = <DateTime>[];

    if (rawDays is List) {
      for (final value in rawDays) {
        if (value is String) {
          final parsed = DateTime.tryParse(value);

          if (parsed != null) {
            days.add(parsed);
          }
        }
      }
    }

    return Habit(
      id: json['id'] as String,
      name: json['name'] as String,
      description: (json['description'] as String?) ?? '',
      iconName: (json['iconName'] as String?) ?? 'task_alt',
      completedDays: days,
      reminderEnabled: (json['reminderEnabled'] as bool?) ?? false,
      reminderHour: json['reminderHour'] as int?,
      reminderMinute: json['reminderMinute'] as int?,
    );
  }

  /// Returns a modified copy of this habit.
  Habit copyWith({
    String? id,
    String? name,
    String? description,
    String? iconName,
    List<DateTime>? completedDays,
    bool? reminderEnabled,
    int? reminderHour,
    int? reminderMinute,
    bool clearReminderTime = false,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      completedDays: completedDays ?? this.completedDays,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderHour: clearReminderTime
          ? null
          : reminderHour ?? this.reminderHour,
      reminderMinute: clearReminderTime
          ? null
          : reminderMinute ?? this.reminderMinute,
    );
  }

  /// Converts this habit to a serializable JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconName': iconName,
      'completedDays': completedDays
          .map((date) => date.toIso8601String())
          .toList(),
      'reminderEnabled': reminderEnabled,
      'reminderHour': reminderHour,
      'reminderMinute': reminderMinute,
    };
  }

  /// Checks if the habit was completed today.
  bool isCompletedToday() {
    final today = DateTime.now();

    return completedDays.any(
      (date) =>
          date.year == today.year &&
          date.month == today.month &&
          date.day == today.day,
    );
  }

  /// Calculates the current streak of consecutive days the habit
  ///  has been completed.
  int calculateStreak() {
    if (completedDays.isEmpty) return 0;

    final sorted = completedDays.toList()..sort((a, b) => b.compareTo(a));

    int streak = 0;

    DateTime? previous;

    for (final date in sorted) {
      if (previous == null) {
        if (!date.isSameDay(DateTime.now()) &&
            !date.isSameDay(DateTime.now().subtract(const Duration(days: 1)))) {
          return 0;
        }

        streak = 1;
        previous = date;
        continue;
      }

      final expected = previous.subtract(const Duration(days: 1));

      if (date.isSameDay(expected)) {
        streak++;
        previous = date;
      } else {
        break;
      }
    }

    return streak;
  }
}
