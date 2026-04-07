// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Single metric card used in profile stats overview.
class ProfileStatCard extends StatelessWidget {
  static const _cardWidth = 160.0;

  final String title;
  final String value;
  final String subtitle;
  final Color color;

  /// Creates [ProfileStatCard].
  const ProfileStatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: _cardWidth,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
