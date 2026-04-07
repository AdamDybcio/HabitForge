// ignore_for_file: prefer_match_file_name

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/controllers/locale_controller.dart';
import 'package:habit_forge/controllers/navigation_controller.dart';
import 'package:habit_forge/controllers/theme_controller.dart';
import 'package:habit_forge/l10n/app_localizations.dart';
import 'package:habit_forge/services/locale_local_storage_service.dart';
import 'package:habit_forge/views/main_navigation_screen.dart';
import 'package:provider/provider.dart';

import '../support/test_doubles.dart';

class _FakeLocaleLocalStorageService extends LocaleLocalStorageService {
  Locale? storedLocale;

  @override
  Future<Locale?> loadLocale() async {
    return storedLocale;
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    storedLocale = locale;
  }
}

void main() {
  group('MainNavigationScreen localization', () {
    testWidgets('updates tab labels after locale change', (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });

      final localeStorage = _FakeLocaleLocalStorageService();
      final localeController = LocaleController(storage: localeStorage);
      final homeController = HomeController(
        storage: InMemoryHabitStorageService(),
        enableDayRolloverTicker: false,
      );

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HomeController>.value(value: homeController),
            ChangeNotifierProvider<NavigationController>(
              create: (_) => NavigationController(),
            ),
            ChangeNotifierProvider<ThemeController>(
              create: (_) => ThemeController(),
            ),
            ChangeNotifierProvider<LocaleController>.value(
              value: localeController,
            ),
          ],
          child: Consumer<LocaleController>(
            builder: (_, controller, __) {
              return MaterialApp(
                locale: controller.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                home: const MainNavigationScreen(),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      await localeController.setLocale(const Locale('pl'));
      await tester.pumpAndSettle();

      expect(find.text('Start'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
      expect(localeStorage.storedLocale, const Locale('pl'));
    });
  });
}
