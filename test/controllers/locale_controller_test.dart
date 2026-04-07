// ignore_for_file: prefer_match_file_name

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/locale_controller.dart';
import 'package:habit_forge/services/locale_local_storage_service.dart';

class _FakeLocaleLocalStorageService extends LocaleLocalStorageService {
  Locale? storedLocale;

  _FakeLocaleLocalStorageService({this.storedLocale});

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
  group('LocaleController', () {
    test('starts with english locale by default', () {
      final controller = LocaleController(
        storage: _FakeLocaleLocalStorageService(),
      );

      expect(controller.locale, const Locale('en'));
    });

    test('loads persisted locale on initialize', () async {
      final controller = LocaleController(
        storage: _FakeLocaleLocalStorageService(
          storedLocale: const Locale('pl'),
        ),
      );

      await controller.initialize();

      expect(controller.locale, const Locale('pl'));
    });

    test('setLocale persists and notifies listeners', () async {
      final storage = _FakeLocaleLocalStorageService();
      final controller = LocaleController(storage: storage);
      var notifications = 0;
      controller.addListener(() => notifications++);

      await controller.setLocale(const Locale('pl'));

      expect(controller.locale, const Locale('pl'));
      expect(storage.storedLocale, const Locale('pl'));
      expect(notifications, 1);
    });

    test('ignores unsupported locale values', () async {
      final controller = LocaleController(
        storage: _FakeLocaleLocalStorageService(),
      );

      await controller.setLocale(const Locale('de'));

      expect(controller.locale, const Locale('en'));
    });
  });
}
