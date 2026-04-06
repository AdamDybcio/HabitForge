import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// Bootstraps Hive for local persistence.
class HiveService {
  static bool _isInitialized = false;

  /// Initializes Hive once with the app documents directory.
  static Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    _isInitialized = true;
  }
}
