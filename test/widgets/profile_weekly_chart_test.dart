import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/widgets/profile/profile_weekly_chart.dart';

void main() {
  const weekDaysCount = 7;

  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  group('ProfileWeeklyChart', () {
    testWidgets('renders chart title, legend and bars', (tester) async {
      await tester.pumpWidget(
        wrap(const ProfileWeeklyChart(completions: [1, 2, 0, 3, 1, 2, 4])),
      );

      expect(find.text('Last 7 days'), findsOneWidget);
      expect(find.text('Completed habits per day'), findsOneWidget);
      expect(find.text('Mon-Sun timeline (last 7 days)'), findsOneWidget);
      expect(find.byType(BarChart), findsOneWidget);
    });

    testWidgets('enables readable axes and tooltip interaction', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(const ProfileWeeklyChart(completions: [1, 2, 0, 3, 1, 2, 4])),
      );

      final chart = tester.widget<BarChart>(find.byType(BarChart));
      final data = chart.data;

      expect(data.titlesData.leftTitles.sideTitles.showTitles, isTrue);
      expect(data.titlesData.bottomTitles.sideTitles.showTitles, isTrue);
      expect(data.barTouchData.enabled, isTrue);
      expect(data.barTouchData.touchTooltipData.fitInsideHorizontally, isTrue);
      expect(data.barTouchData.touchTooltipData.fitInsideVertically, isTrue);
      expect(data.barGroups.length, weekDaysCount);
    });
  });
}
