import 'package:equatable/equatable.dart';
import 'package:habit_forge/core/extensions/date_extensions.dart';

/// A model representing a habit with its name and the days it was completed.
class Habit extends Equatable {
  /// Unique identifier for the habit.
  final String id;

  /// Name of the habit.
  final String name;

  /// List of dates when the habit was completed.
  final List<DateTime> completedDays;

  @override
  List<Object?> get props => [id, name, completedDays];

  /// Creates a new [Habit] instance.
  const Habit({
    required this.id,
    required this.name,
    required this.completedDays,
  });

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
