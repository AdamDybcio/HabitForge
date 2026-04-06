// ignore_for_file: prefer_match_file_name

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/controllers/navigation_controller.dart';
import 'package:habit_forge/core/theme/app_theme.dart';
import 'package:habit_forge/services/habit_local_storage_service.dart';
import 'package:habit_forge/views/main_navigation_screen.dart';
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
          )..initialize(),
        ),
        ChangeNotifierProvider<NavigationController>(
          create: (_) => NavigationController(),
        ),
      ],
      child: MaterialApp(
        title: 'HabitForge',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('pl'),
        ],
        home: const MainNavigationScreen(),
      ),
    );
  }
}
