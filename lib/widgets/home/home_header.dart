import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/colors.dart';

/// Top header with branded logo and theme-toggle placeholder.
class HomeHeader extends StatelessWidget {
  static const _logoSize = 44.0;
  static const _iconSize = 22.0;
  static const _logoRadius = 14.0;

  /// Creates [HomeHeader].
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: _logoSize,
          height: _logoSize,
          decoration: const BoxDecoration(
            gradient: AppEffects.ctaGradient,
            borderRadius: BorderRadius.all(Radius.circular(_logoRadius)),
            boxShadow: AppEffects.ambientShadow,
          ),
          child: const Icon(
            Icons.local_fire_department,
            color: Colors.white,
            size: _iconSize,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.titleLarge,
              children: const [
                TextSpan(text: 'Habit'),
                TextSpan(
                  text: 'Forge',
                  style: TextStyle(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
        const IconButton(
          onPressed: null,
          tooltip: 'Przełącz motyw',
          icon: Icon(Icons.dark_mode_outlined),
        ),
      ],
    );
  }
}
