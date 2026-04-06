import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/colors.dart';

/// Animated completion summary with percentage text and progress bar.
class AnimatedCompletionProgress extends StatelessWidget {
  static const _trackHeight = 10.0;

  /// Completed habits count for today.
  final int completed;

  /// Total habits count.
  final int total;

  /// Creates [AnimatedCompletionProgress].
  const AnimatedCompletionProgress({
    required this.completed,
    required this.total,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final safeCompleted = completed.clamp(0, total);
    final targetProgress = total == 0 ? 0.0 : safeCompleted / total;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetProgress),
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutCubic,
      builder: (context, animatedProgress, _) {
        final animatedPercentage = (animatedProgress * 100).round();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '$animatedPercentage% Complete',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '$safeCompleted/$total',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(999)),
              child: LinearProgressIndicator(
                value: animatedProgress,
                minHeight: _trackHeight,
                backgroundColor: AppColors.surfaceContainerHigh,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
