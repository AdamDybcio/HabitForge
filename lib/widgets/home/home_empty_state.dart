import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';
import 'package:habit_forge/core/theme/colors.dart';

/// Empty state shown when there are no habits yet.
class HomeEmptyState extends StatelessWidget {
  static const _emptyCardRadius = 24.0;

  /// Callback to create first habit.
  final VoidCallback onCreate;

  /// Creates [HomeEmptyState].
  const HomeEmptyState({required this.onCreate, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = appL10n(context);

    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: const BorderRadius.all(
            Radius.circular(_emptyCardRadius),
          ),
          boxShadow: AppEffects.ambientShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                gradient: AppEffects.ctaGradient,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Icon(Icons.track_changes, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noHabitsYetTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noHabitsYetDescription,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add),
              label: Text(l10n.createFirstHabit),
            ),
          ],
        ),
      ),
    );
  }
}
