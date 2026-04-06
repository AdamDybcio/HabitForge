import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/widgets/profile/profile_stats_overview.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  group('ProfileStatsOverview', () {
    testWidgets('renders all metric cards and computed completion rate', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          const ProfileStatsOverview(
            totalHabits: 4,
            completedToday: 3,
            totalCompletions: 42,
            bestCurrentStreak: 7,
          ),
        ),
      );

      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Completion'), findsOneWidget);
      expect(find.text('All Time'), findsOneWidget);
      expect(find.text('Best Streak'), findsOneWidget);

      expect(find.text('3/4'), findsOneWidget);
      expect(find.text('75%'), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('shows zero completion rate when no habits exist', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          const ProfileStatsOverview(
            totalHabits: 0,
            completedToday: 0,
            totalCompletions: 0,
            bestCurrentStreak: 0,
          ),
        ),
      );

      expect(find.text('0%'), findsOneWidget);
      expect(find.text('0/0'), findsOneWidget);
    });
  });
}
