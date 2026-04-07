import 'package:hive/hive.dart';

/// Persists onboarding completion state using Hive.
class OnboardingLocalStorageService {
  static const _boxName = 'habit_forge_settings_box';
  static const _onboardingCompletedKey = 'onboarding_completed';

  Future<Box<dynamic>> _openBox() {
    return Hive.openBox<dynamic>(_boxName);
  }

  /// Returns true when onboarding has already been completed.
  Future<bool> loadOnboardingCompleted() async {
    final box = await _openBox();

    return box.get(_onboardingCompletedKey) as bool? ?? false;
  }

  /// Marks onboarding as completed.
  Future<void> saveOnboardingCompleted() async {
    final box = await _openBox();

    await box.put(_onboardingCompletedKey, true);
  }
}
