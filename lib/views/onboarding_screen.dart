import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';
import 'package:habit_forge/core/theme/colors.dart';
import 'package:habit_forge/widgets/onboarding/onboarding_point.dart';

/// First-run onboarding screen shown only once.
class OnboardingScreen extends StatelessWidget {
  /// Whether onboarding action is currently being persisted.
  final bool isSubmitting;

  /// Callback invoked when the user finishes onboarding.
  final Future<void> Function() onGetStarted;

  /// Creates [OnboardingScreen].
  const OnboardingScreen({
    required this.isSubmitting,
    required this.onGetStarted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = appL10n(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  gradient: AppEffects.ctaGradient,
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  boxShadow: AppEffects.ambientShadow,
                ),
                child: const Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.onboardingTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                l10n.onboardingSubtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 28),
              OnboardingPoint(text: l10n.onboardingPointConsistency),
              const SizedBox(height: 12),
              OnboardingPoint(text: l10n.onboardingPointProgress),
              const SizedBox(height: 12),
              OnboardingPoint(text: l10n.onboardingPointFocus),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: isSubmitting ? null : onGetStarted,
                  child: isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.onboardingGetStarted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
