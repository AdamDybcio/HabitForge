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

  @override
  List<Object?> get props => [id, name, description, iconName, completedDays];

  /// Creates a new [Habit] instance.
  const Habit({
    required this.id,
    required this.name,
    required this.completedDays,
    this.description = '',
    this.iconName = 'task_alt',
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
    );
  }

  /// Returns a modified copy of this habit.
  Habit copyWith({
    String? id,
    String? name,
    String? description,
    String? iconName,
    List<DateTime>? completedDays,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      completedDays: completedDays ?? this.completedDays,
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
