import 'package:flutter/material.dart';

/// Animated streak badge with fire icon and numeric streak.
class AnimatedStreakBadge extends StatelessWidget {
  static const _background = Color(0xFFFFE6D9);
  static const _foreground = Color(0xFFE85D04);

  /// Current streak value.
  final int streak;

  /// Creates [AnimatedStreakBadge].
  const AnimatedStreakBadge({required this.streak, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: const BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.local_fire_department,
              size: 16,
              color: _foreground,
            ),
            const SizedBox(width: 4),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              switchInCurve: Curves.easeOutBack,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                final slide = Tween<Offset>(
                  begin: const Offset(0, 0.25),
                  end: Offset.zero,
                ).animate(animation);

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(position: slide, child: child),
                );
              },
              child: Text(
                '$streak',
                key: ValueKey<int>(streak),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: _foreground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
