import 'package:flutter/material.dart';
import 'package:habit_forge/controllers/theme_controller.dart';
import 'package:habit_forge/core/theme/colors.dart';
import 'package:provider/provider.dart';

/// Top header with branded logo and theme toggle action.
class HomeHeader extends StatelessWidget {
  static const _logoSize = 44.0;
  static const _iconSize = 22.0;
  static const _logoRadius = 14.0;

  /// Creates [HomeHeader].
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final colorScheme = Theme.of(context).colorScheme;

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
              children: [
                const TextSpan(text: 'Habit'),
                TextSpan(
                  text: 'Forge',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: themeController.toggleTheme,
          tooltip: 'Change theme',
          icon: Icon(
            themeController.isDarkMode
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
