import 'package:flutter/material.dart';
import 'package:habit_forge/services/locale_local_storage_service.dart';

/// Controller managing application locale.
class LocaleController extends ChangeNotifier {
  final LocaleLocalStorageService _storage;

  /// Supported locales.
  static const supportedLocales = [
    Locale('en'),
    Locale('pl'),
  ];

  Locale _locale = const Locale('en');

  /// Currently selected locale.
  Locale get locale => _locale;

  /// Creates [LocaleController].
  LocaleController({LocaleLocalStorageService? storage})
    : _storage = storage ?? LocaleLocalStorageService();

  /// Loads persisted locale.
  Future<void> initialize() async {
    final persistedLocale = await _storage.loadLocale();

    if (persistedLocale == null || persistedLocale == _locale) {
      return;
    }

    _locale = persistedLocale;
    notifyListeners();
  }

  /// Updates locale and persists selection.
  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.any(
      (item) => item.languageCode == locale.languageCode,
    )) {
      return;
    }

    if (_locale == locale) {
      return;
    }

    _locale = locale;
    notifyListeners();

    await _storage.saveLocale(locale);
  }
}
