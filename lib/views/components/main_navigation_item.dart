// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Single bottom-navigation item used in main navigation screen.
class MainNavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  /// Creates [MainNavigationItem].
  const MainNavigationItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isSelected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;
    final fontWeight = isSelected ? FontWeight.w700 : FontWeight.w600;
    final baseLabelStyle =
        Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        onTap: onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutBack,
          scale: isSelected ? 1 : 0.96,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.surfaceContainerLowest
                  : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(14)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutBack,
                  scale: isSelected ? 1.08 : 1,
                  child: Icon(icon, color: color),
                ),
                const SizedBox(height: 2),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  style: baseLabelStyle.copyWith(
                    color: color,
                    fontWeight: fontWeight,
                  ),
                  child: Text(label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
