import 'package:flutter/material.dart';

/// Bullet point row used in onboarding content.
class OnboardingPoint extends StatelessWidget {
  /// Description text for a single onboarding point.
  final String text;

  /// Creates [OnboardingPoint].
  const OnboardingPoint({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_rounded, color: colorScheme.primary, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
