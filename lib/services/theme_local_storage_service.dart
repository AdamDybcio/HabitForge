import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// Persists selected theme mode using Hive.
class ThemeLocalStorageService {
  static const _boxName = 'habit_forge_settings_box';
  static const _themeModeKey = 'theme_mode';

  Future<Box<dynamic>> _openBox() {
    return Hive.openBox<dynamic>(_boxName);
  }

  /// Loads persisted theme mode if available.
  Future<ThemeMode?> loadThemeMode() async {
    final box = await _openBox();
    final stored = box.get(_themeModeKey);

    if (stored is! String) {
      return null;
    }

    switch (stored) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }

  /// Saves selected theme mode.
  Future<void> saveThemeMode(ThemeMode mode) async {
    final box = await _openBox();

    await box.put(_themeModeKey, mode.name);
  }
}
