import 'package:flutter/material.dart';
import 'package:habit_forge/services/theme_local_storage_service.dart';

/// Controller managing application theme mode.
class ThemeController extends ChangeNotifier {
  final ThemeLocalStorageService _storage;

  ThemeMode _themeMode = ThemeMode.light;

  /// Currently selected theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Returns whether dark mode is currently active.
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Creates [ThemeController].
  ThemeController({ThemeLocalStorageService? storage})
    : _storage = storage ?? ThemeLocalStorageService();

  /// Loads the persisted theme mode.
  Future<void> initialize() async {
    final persistedMode = await _storage.loadThemeMode();

    if (persistedMode == null || persistedMode == _themeMode) {
      return;
    }

    _themeMode = persistedMode;
    notifyListeners();
  }

  /// Toggles between light and dark mode.
  Future<void> toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();

    await _storage.saveThemeMode(_themeMode);
  }
}
