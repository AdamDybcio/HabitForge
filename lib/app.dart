// ignore_for_file: prefer_match_file_name

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habit_forge/controllers/app_launch_controller.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/controllers/locale_controller.dart';
import 'package:habit_forge/controllers/navigation_controller.dart';
import 'package:habit_forge/controllers/theme_controller.dart';
import 'package:habit_forge/core/theme/app_theme.dart';
import 'package:habit_forge/core/widgets/responsive_app_frame.dart';
import 'package:habit_forge/l10n/app_localizations.dart';
import 'package:habit_forge/services/habit_local_storage_service.dart';
import 'package:habit_forge/services/local_notifications_service.dart';
import 'package:habit_forge/views/app_loading_screen.dart';
import 'package:habit_forge/views/main_navigation_screen.dart';
import 'package:habit_forge/views/onboarding_screen.dart';
import 'package:provider/provider.dart';

/// The main application widget.
class HabitForgeApp extends StatelessWidget {
  /// Creates a [HabitForgeApp] widget.
  const HabitForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          create: (_) => HomeController(
            storage: HabitLocalStorageService(),
            reminderScheduler: LocalNotificationsService(),
          )..initialize(),
        ),
        ChangeNotifierProvider<NavigationController>(
          create: (_) => NavigationController(),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController()..initialize(),
        ),
        ChangeNotifierProvider<LocaleController>(
          create: (_) => LocaleController()..initialize(),
        ),
        ChangeNotifierProvider<AppLaunchController>(
          create: (_) => AppLaunchController()..initialize(),
        ),
      ],
      child: Consumer3<ThemeController, LocaleController, AppLaunchController>(
        builder:
            (_, themeController, localeController, appLaunchController, _) {
              final home = !appLaunchController.isInitialized
                  ? const AppLoadingScreen()
                  : appLaunchController.shouldShowOnboarding
                  ? OnboardingScreen(
                      isSubmitting: appLaunchController.isSavingOnboarding,
                      onGetStarted: appLaunchController.completeOnboarding,
                    )
                  : const MainNavigationScreen();

              return MaterialApp(
                title: 'HabitForge',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeController.themeMode,
                locale: localeController.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                builder: (_, child) {
                  if (child == null) {
                    return const SizedBox.shrink();
                  }

                  return ResponsiveAppFrame(child: child);
                },
                home: home,
              );
            },
      ),
    );
  }
}
