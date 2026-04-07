import 'package:flutter/material.dart';
import 'package:habit_forge/services/onboarding_local_storage_service.dart';

/// Controls startup flow between onboarding and main app shell.
class AppLaunchController extends ChangeNotifier {
  final OnboardingLocalStorageService _storage;

  bool _isInitialized = false;
  bool _isOnboardingCompleted = false;
  bool _isSavingOnboarding = false;

  /// Whether startup state is loaded.
  bool get isInitialized => _isInitialized;

  /// Whether onboarding completion is currently being persisted.
  bool get isSavingOnboarding => _isSavingOnboarding;

  /// Whether onboarding should be shown to the user.
  bool get shouldShowOnboarding => _isInitialized && !_isOnboardingCompleted;

  /// Creates [AppLaunchController].
  AppLaunchController({OnboardingLocalStorageService? storage})
    : _storage = storage ?? OnboardingLocalStorageService();

  /// Loads onboarding completion state from persistence.
  Future<void> initialize() async {
    final completed = await _storage.loadOnboardingCompleted();

    _isOnboardingCompleted = completed;
    _isInitialized = true;
    notifyListeners();
  }

  /// Completes onboarding and updates launch state.
  Future<void> completeOnboarding() async {
    if (_isSavingOnboarding || _isOnboardingCompleted) {
      return;
    }

    _isSavingOnboarding = true;
    notifyListeners();

    await _storage.saveOnboardingCompleted();

    _isOnboardingCompleted = true;
    _isSavingOnboarding = false;
    notifyListeners();
  }
}
