import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/l10n/app_localizations.dart';
import 'package:habit_forge/widgets/profile/profile_weekly_chart.dart';

void main() {
  const weekDaysCount = 7;

  Widget wrap(Widget child) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
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

    testWidgets('uses high-contrast tooltip colors in dark mode', (
      tester,
    ) async {
      const completions = [1, 2, 0, 3, 1, 2, 4];

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: ThemeMode.dark,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: ProfileWeeklyChart(completions: completions),
          ),
        ),
      );

      final chart = tester.widget<BarChart>(find.byType(BarChart));
      final data = chart.data;
      final colorScheme = Theme.of(
        tester.element(find.byType(BarChart)),
      ).colorScheme;
      final tooltipColor = data.barTouchData.touchTooltipData.getTooltipColor(
        data.barGroups.first,
      );
      final tooltipItem = data.barTouchData.touchTooltipData.getTooltipItem(
        data.barGroups.first,
        0,
        data.barGroups.first.barRods.first,
        0,
      );

      expect(tooltipColor, colorScheme.inverseSurface);
      expect(tooltipItem?.textStyle.color, colorScheme.onInverseSurface);
    });
  });
}
