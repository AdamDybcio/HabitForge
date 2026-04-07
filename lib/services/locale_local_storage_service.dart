import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// Persists selected locale using Hive.
class LocaleLocalStorageService {
  static const _boxName = 'habit_forge_settings_box';
  static const _localeCodeKey = 'locale_code';

  Future<Box<dynamic>> _openBox() {
    return Hive.openBox<dynamic>(_boxName);
  }

  /// Loads persisted locale if available.
  Future<Locale?> loadLocale() async {
    final box = await _openBox();
    final stored = box.get(_localeCodeKey);

    if (stored is! String || stored.isEmpty) {
      return null;
    }

    switch (stored) {
      case 'pl':
        return const Locale('pl');
      case 'en':
        return const Locale('en');
      default:
        return null;
    }
  }

  /// Saves selected locale.
  Future<void> saveLocale(Locale locale) async {
    final box = await _openBox();

    await box.put(_localeCodeKey, locale.languageCode);
  }
}
