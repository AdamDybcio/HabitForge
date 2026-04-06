import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/widgets/profile/profile_monthly_calendar.dart';

void main() {
  const expectedYear = 2026;
  const expectedMonth = 4;
  const expectedDay = 10;

  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }

  group('ProfileMonthlyCalendar', () {
    testWidgets('triggers month navigation callbacks', (tester) async {
      var previousTapped = false;
      var nextTapped = false;

      await tester.pumpWidget(
        wrap(
          ProfileMonthlyCalendar(
            focusedMonth: DateTime(expectedYear, expectedMonth),
            selectedDay: DateTime(expectedYear, expectedMonth, expectedDay),
            completionCountByDay: const <DateTime, int>{},
            onSelectDay: (_) => fail('Select day should not be called here'),
            onPreviousMonth: () => previousTapped = true,
            onNextMonth: () => nextTapped = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.chevron_left_rounded));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.chevron_right_rounded));
      await tester.pump();

      expect(previousTapped, isTrue);
      expect(nextTapped, isTrue);
    });

    testWidgets('selects day from calendar grid', (tester) async {
      DateTime? selected;

      await tester.pumpWidget(
        wrap(
          ProfileMonthlyCalendar(
            focusedMonth: DateTime(expectedYear, expectedMonth),
            selectedDay: DateTime(expectedYear, expectedMonth),
            completionCountByDay: <DateTime, int>{
              DateTime(expectedYear, expectedMonth, expectedDay): 2,
            },
            onSelectDay: (day) => selected = day,
            onPreviousMonth: () =>
                fail('Previous month should not be called here'),
            onNextMonth: () => fail('Next month should not be called here'),
          ),
        ),
      );

      await tester.tap(find.text(expectedDay.toString()).first);
      await tester.pump();

      expect(selected, isNotNull);
      expect(selected?.year, expectedYear);
      expect(selected?.month, expectedMonth);
      expect(selected?.day, expectedDay);
    });
  });
}
