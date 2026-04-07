import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/l10n/app_localizations.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/habit/create_habit_bottom_sheet.dart';
import '../support/test_doubles.dart';

void main() {
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

  group('CreateHabitBottomSheet', () {
    testWidgets('validates required name', (tester) async {
      final controller = HomeController(
        storage: InMemoryHabitStorageService(),
        enableDayRolloverTicker: false,
      );

      await tester.pumpWidget(
        wrap(CreateHabitBottomSheet(controller: controller)),
      );

      expect(find.text('Create Habit'), findsOneWidget);

      await tester.tap(find.text('Create habit'));
      await tester.pumpAndSettle();

      expect(find.text('Name is required'), findsOneWidget);
    });

    testWidgets('creates a habit with filled form', (tester) async {
      final storage = InMemoryHabitStorageService();
      final controller = HomeController(
        storage: storage,
        uuid: FixedUuid(['habit-1']),
        enableDayRolloverTicker: false,
      );

      await tester.pumpWidget(
        wrap(CreateHabitBottomSheet(controller: controller)),
      );

      await tester.enterText(find.byType(TextFormField).first, '  Hydrate  ');
      await tester.enterText(
        find.byType(TextFormField).at(1),
        '  At least 2L  ',
      );

      await tester.tap(find.byIcon(Icons.water_drop).first);
      await tester.pump();

      await tester.tap(find.text('Create habit'));
      await tester.pumpAndSettle();

      expect(controller.habits, hasLength(1));
      final habit = controller.habits.single;
      expect(habit.name, 'Hydrate');
      expect(habit.description, 'At least 2L');
      expect(habit.iconName, 'water_drop');
    });

    testWidgets('prefills and updates habit in edit mode', (tester) async {
      const existing = Habit(
        id: 'habit-1',
        name: 'Read',
        description: '10 pages',
        iconName: 'book',
        completedDays: <DateTime>[],
      );
      final storage = InMemoryHabitStorageService(initialHabits: [existing]);
      final controller = HomeController(
        storage: storage,
        enableDayRolloverTicker: false,
      );
      await controller.initialize();

      await tester.pumpWidget(
        wrap(
          CreateHabitBottomSheet(
            controller: controller,
            initialHabit: existing,
          ),
        ),
      );

      expect(find.text('Edit Habit'), findsOneWidget);
      expect(find.text('Save changes'), findsOneWidget);
      expect(find.text('Read'), findsOneWidget);
      expect(find.text('10 pages'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).first, 'Deep work');
      await tester.enterText(find.byType(TextFormField).at(1), '45 min');
      await tester.tap(find.byIcon(Icons.code).first);
      await tester.pump();

      await tester.tap(find.text('Save changes'));
      await tester.pumpAndSettle();

      final updated = controller.habits.single;
      expect(updated.name, 'Deep work');
      expect(updated.description, '45 min');
      expect(updated.iconName, 'code');
    });
  });
}
