import 'package:hive_flutter/hive_flutter.dart';

/// Bootstraps Hive for local persistence.
class HiveService {
  static bool _isInitialized = false;

  /// Initializes Hive once with the app documents directory.
  static Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    await Hive.initFlutter();
    _isInitialized = true;
  }
}
