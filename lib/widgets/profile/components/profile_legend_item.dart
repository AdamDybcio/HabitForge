// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/colors.dart';

/// Legend row item used in profile weekly chart.
class ProfileLegendItem extends StatelessWidget {
  final String label;
  final bool useGradient;
  final double dotSize;

  /// Creates [ProfileLegendItem].
  const ProfileLegendItem({
    required this.label,
    required this.dotSize,
    this.useGradient = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: useGradient ? null : colorScheme.outlineVariant,
            gradient: useGradient ? AppEffects.ctaGradient : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
