import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/colors.dart';

/// Animated square toggle button for marking habit completion.
class AnimatedCompletionToggleButton extends StatelessWidget {
  static const _size = 46.0;

  /// Whether habit is completed today.
  final bool isCompleted;

  /// Callback fired on tap.
  final VoidCallback onTap;

  /// Creates [AnimatedCompletionToggleButton].
  const AnimatedCompletionToggleButton({
    required this.isCompleted,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutBack,
      scale: isCompleted ? 1 : 0.96,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: isCompleted ? AppColors.secondary : AppColors.primary,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            child: SizedBox(
              width: _size,
              height: _size,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    isCompleted ? Icons.check : Icons.circle_outlined,
                    key: ValueKey<bool>(isCompleted),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
