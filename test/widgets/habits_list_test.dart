import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/l10n/app_localizations.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/habit/habits_list.dart';
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

  group('HabitsList', () {
    testWidgets('shows empty state and triggers create callback', (
      tester,
    ) async {
      final controller = HomeController(
        storage: InMemoryHabitStorageService(),
        enableDayRolloverTicker: false,
      );
      var createTapped = false;

      await tester.pumpWidget(
        wrap(
          HabitsList(
            controller: controller,
            onCreateHabit: () => createTapped = true,
            onEditHabit: (_) =>
                fail('Edit should not be triggered in empty state'),
            onDeleteHabit: (_) =>
                fail('Delete should not be triggered in empty state'),
          ),
        ),
      );

      expect(find.text('No habits yet'), findsOneWidget);

      await tester.tap(find.text('Create first habit'));
      await tester.pump();

      expect(createTapped, isTrue);
    });

    testWidgets('renders habits and toggles completion', (tester) async {
      final storage = InMemoryHabitStorageService();
      final controller = HomeController(
        storage: storage,
        uuid: FixedUuid(['habit-1']),
        enableDayRolloverTicker: false,
      );
      await controller.addHabit(name: 'Morning walk', description: '20 min');

      await tester.pumpWidget(
        wrap(
          HabitsList(
            controller: controller,
            onCreateHabit: () => fail('Create should not be triggered here'),
            onEditHabit: (_) => fail('Edit should not be triggered here'),
            onDeleteHabit: (_) => fail('Delete should not be triggered here'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Morning walk'), findsOneWidget);
      expect(find.text('Tap to complete'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.circle_outlined).first);
      await tester.pump();
      await tester.pumpWidget(
        wrap(
          HabitsList(
            controller: controller,
            onCreateHabit: () => fail('Create should not be triggered here'),
            onEditHabit: (_) => fail('Edit should not be triggered here'),
            onDeleteHabit: (_) => fail('Delete should not be triggered here'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Completed today'), findsOneWidget);
    });

    testWidgets('calls edit and delete callbacks from habit menu', (
      tester,
    ) async {
      final storage = InMemoryHabitStorageService();
      final controller = HomeController(
        storage: storage,
        uuid: FixedUuid(['habit-1']),
        enableDayRolloverTicker: false,
      );
      await controller.addHabit(name: 'Read', iconName: 'book');

      Habit? edited;
      Habit? deleted;

      await tester.pumpWidget(
        wrap(
          HabitsList(
            controller: controller,
            onCreateHabit: () => fail('Create should not be triggered here'),
            onEditHabit: (habit) => edited = habit,
            onDeleteHabit: (habit) => deleted = habit,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.more_horiz).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit').last);
      await tester.pumpAndSettle();

      expect(edited?.name, 'Read');

      await tester.tap(find.byIcon(Icons.more_horiz).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();

      expect(deleted?.name, 'Read');
    });
  });
}
