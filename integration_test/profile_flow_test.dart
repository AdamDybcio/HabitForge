import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/controllers/locale_controller.dart';
import 'package:habit_forge/controllers/navigation_controller.dart';
import 'package:habit_forge/controllers/theme_controller.dart';
import 'package:habit_forge/core/theme/app_theme.dart';
import 'package:habit_forge/l10n/app_localizations.dart';
import 'package:habit_forge/views/main_navigation_screen.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

import 'support/test_doubles.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget appWithController(HomeController controller) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>.value(value: controller),
        ChangeNotifierProvider<NavigationController>(
          create: (_) => NavigationController(),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
        ChangeNotifierProvider<LocaleController>(
          create: (_) => LocaleController(),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const MainNavigationScreen(),
      ),
    );
  }

  group('Profile integration flow', () {
    testWidgets('user can open profile tab and see analytics sections', (
      tester,
    ) async {
      final controller = HomeController(
        storage: InMemoryHabitStorageService(),
        enableDayRolloverTicker: false,
      );

      await tester.pumpWidget(appWithController(controller));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      expect(find.text('Last 7 days'), findsOneWidget);
      expect(find.textContaining('Track consistency'), findsOneWidget);
      expect(find.textContaining('Completed on'), findsOneWidget);
    });

    testWidgets('profile reflects habit completion from home tab', (
      tester,
    ) async {
      final controller = HomeController(
        storage: InMemoryHabitStorageService(),
        uuid: FixedUuid(['habit-1']),
        enableDayRolloverTicker: false,
      );

      await tester.pumpWidget(appWithController(controller));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).first,
        'Morning stretch',
      );
      await tester.enterText(find.byType(TextFormField).at(1), '5 min');
      await tester.tap(find.text('Create habit'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.circle_outlined).first);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      expect(find.text('1/1'), findsOneWidget);
      expect(find.text('100%'), findsOneWidget);
      expect(find.text('Morning stretch'), findsOneWidget);
    });
  });
}
