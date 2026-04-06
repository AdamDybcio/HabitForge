// ignore_for_file: prefer_match_file_name

import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/app_theme.dart';
import 'package:habit_forge/views/home_screen.dart';

/// The main application widget.
class HabitForgeApp extends StatelessWidget {
  /// Creates a [HabitForgeApp] widget.
  const HabitForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitForge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
