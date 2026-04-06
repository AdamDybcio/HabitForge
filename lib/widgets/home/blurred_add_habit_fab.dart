import 'dart:ui';

import 'package:flutter/material.dart';

/// Frosted floating action button with subtle background blur.
class BlurredAddHabitFab extends StatelessWidget {
  static const _fabSize = 66.0;

  /// Action executed when user taps the button.
  final VoidCallback onPressed;

  /// Creates [BlurredAddHabitFab].
  const BlurredAddHabitFab({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Material(
          color: colorScheme.surfaceContainerLowest.withValues(alpha: 0.88),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Ink(
              width: _fabSize,
              height: _fabSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.35),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 88, 190, 0.22),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary.withValues(alpha: 0.9),
                    colorScheme.primaryContainer.withValues(alpha: 0.88),
                  ],
                ),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
