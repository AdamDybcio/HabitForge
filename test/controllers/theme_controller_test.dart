// ignore_for_file: prefer_match_file_name

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/theme_controller.dart';
import 'package:habit_forge/services/theme_local_storage_service.dart';

class _FakeThemeLocalStorageService extends ThemeLocalStorageService {
  ThemeMode? storedMode;

  _FakeThemeLocalStorageService({this.storedMode});

  @override
  Future<ThemeMode?> loadThemeMode() async {
    return storedMode;
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    storedMode = mode;
  }
}

void main() {
  group('ThemeController', () {
    test('starts in light mode', () {
      final controller = ThemeController(
        storage: _FakeThemeLocalStorageService(),
      );

      expect(controller.themeMode, ThemeMode.light);
      expect(controller.isDarkMode, isFalse);
    });

    test('toggles from light to dark and notifies listeners', () async {
      final storage = _FakeThemeLocalStorageService();
      final controller = ThemeController(storage: storage);
      var notifications = 0;
      controller.addListener(() => notifications++);

      await controller.toggleTheme();

      expect(controller.themeMode, ThemeMode.dark);
      expect(controller.isDarkMode, isTrue);
      expect(notifications, 1);
      expect(storage.storedMode, ThemeMode.dark);
    });

    test('toggles back from dark to light', () async {
      final controller = ThemeController(
        storage: _FakeThemeLocalStorageService(),
      );

      await controller.toggleTheme();
      await controller.toggleTheme();

      expect(controller.themeMode, ThemeMode.light);
      expect(controller.isDarkMode, isFalse);
    });

    test('loads persisted theme mode on initialize', () async {
      final controller = ThemeController(
        storage: _FakeThemeLocalStorageService(storedMode: ThemeMode.dark),
      );

      await controller.initialize();

      expect(controller.themeMode, ThemeMode.dark);
      expect(controller.isDarkMode, isTrue);
    });
  });
}
