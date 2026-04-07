// ignore_for_file: prefer_match_file_name

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/app_launch_controller.dart';
import 'package:habit_forge/services/onboarding_local_storage_service.dart';

class _FakeOnboardingLocalStorageService extends OnboardingLocalStorageService {
  bool onboardingCompleted;

  _FakeOnboardingLocalStorageService({this.onboardingCompleted = false});

  @override
  Future<bool> loadOnboardingCompleted() async {
    return onboardingCompleted;
  }

  @override
  Future<void> saveOnboardingCompleted() async {
    onboardingCompleted = true;
  }
}

void main() {
  group('AppLaunchController', () {
    test('shows onboarding on first launch', () async {
      final controller = AppLaunchController(
        storage: _FakeOnboardingLocalStorageService(),
      );

      await controller.initialize();

      expect(controller.isInitialized, isTrue);
      expect(controller.shouldShowOnboarding, isTrue);
    });

    test('skips onboarding when already completed', () async {
      final controller = AppLaunchController(
        storage: _FakeOnboardingLocalStorageService(onboardingCompleted: true),
      );

      await controller.initialize();

      expect(controller.isInitialized, isTrue);
      expect(controller.shouldShowOnboarding, isFalse);
    });

    test('completes onboarding and persists flag', () async {
      final storage = _FakeOnboardingLocalStorageService();
      final controller = AppLaunchController(storage: storage);

      await controller.initialize();
      await controller.completeOnboarding();

      expect(storage.onboardingCompleted, isTrue);
      expect(controller.shouldShowOnboarding, isFalse);
      expect(controller.isSavingOnboarding, isFalse);
    });
  });
}
